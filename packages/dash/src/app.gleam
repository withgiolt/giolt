import app/lib/auth
import gleam/javascript/promise
import gleam/option
import lustre
import lustre/effect.{type Effect}
import modem
import rsvp

import app/effects/get_user_data.{get_user_data}
import app/model.{type Model}

// Routing
import app/lib/route_guard.{route_guard}
import app/lib/routing
import app/routes

pub fn main() {
	use init <- promise.await(init(Nil))
	let app = lustre.application(fn(_) { init }, update, view)
	let assert Ok(_) = lustre.start(app, "#app", Nil)

	promise.resolve(Nil)
}

type Message {
	OnRouteChange(routing.Route)
	OnUserChanged(auth.User)
	OnApiReturnedUserData(Result(auth.UserData, rsvp.Error(String)))
	UserLogout
}

fn init(_) -> promise.Promise(#(Model, Effect(Message))) {
	let route = case modem.initial_uri() {
		Ok(uri) -> routing.parse_route(uri)
		Error(_) -> routing.Index
	}

	let model =
		model.Model(
			user: auth.NotLoaded,
			user_data: auth.UserDataNotLoaded,
			route:,
			error: option.None,
		)

	let effect =
		effect.batch([
			modem.init(fn(uri) {
				uri
				|> routing.parse_route
				|> OnRouteChange
			}),
			effect.from(fn(dispatch) {
				auth.create_auth_listener(fn(user, _) { dispatch(OnUserChanged(user)) })
			}),
			effect.from(fn(dispatch) {
				promise.await(auth.validate_session(), fn(user) {
					dispatch(OnUserChanged(user))
					promise.resolve(Nil)
				})
				Nil
			}),
		])

	promise.resolve(#(model, effect))
}

fn update(model: Model, msg: Message) -> #(Model, Effect(Message)) {
	case msg {
		OnUserChanged(user) -> {
			case user {
				auth.NotLoaded -> model.Model(..model, user:) |> route_guard([])
				auth.NoUser ->
					model.Model(..model, user:, user_data: auth.UserDataNoUser)
					|> route_guard([])
				auth.User(..) ->
					model.Model(..model, user:, user_data: auth.UserDataNotLoaded)
					|> route_guard([
						get_user_data(
							on_response: OnApiReturnedUserData,
							token: user.session_token,
						),
					])
			}
		}
		OnRouteChange(route) -> model.Model(..model, route:) |> route_guard([])
		UserLogout -> {
			model
			|> route_guard([
				effect.from(fn(dispatch) {
					auth.logout()
					dispatch(OnUserChanged(auth.NoUser))
				}),
			])
		}

		OnApiReturnedUserData(Ok(user_data)) ->
			model.Model(..model, user_data:) |> route_guard([])
		OnApiReturnedUserData(Error(_)) -> #(
			model.Model(..model, error: option.Some("Failed to get user data")),
			effect.none(),
		)
	}
}

fn view(model: Model) {
	case model.user, model.user_data {
		auth.NotLoaded, auth.UserDataNotLoaded -> routes.loading_page()
		_, _ ->
			case model.error {
				option.Some(reason) -> routes.error_page(model, reason)
				option.None ->
					case model.route {
						routing.Index -> routes.index_page(model)
						routing.Account -> routes.account_page(model, UserLogout)
						routing.Onboard -> routes.onboard_page(model)
						routing.Cli -> routes.cli_page(model)
						routing.Login -> routes.login_page(model)
						routing.NotFound -> routes.not_found_page(model)
					}
			}
	}
}
