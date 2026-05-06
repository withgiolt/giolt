import app/lib/auth
import gleam/javascript/promise
import lustre
import lustre/effect.{type Effect}
import modem
import rsvp
import app/effects/get_cli_token.{get_cli_token}

import app/model.{type Model}

// Routing
import app/lib/routing
import app/lib/routing/route_guard.{route_guard}
import app/lib/routing/routes

pub fn main() {
	use init <- promise.await(init(Nil))
	let app = lustre.application(fn(_) { init }, update, view)
	let assert Ok(_) = lustre.start(app, "#app", Nil)

	promise.resolve(Nil)
}

type Message {
	OnRouteChange(routing.Route)
	OnUserChanged(auth.User)
	UserRequestedCliToken
	OnApiReturnedCliToken(Result(String, rsvp.Error(String)))
	UserLogout
}

fn init(_) -> promise.Promise(#(Model, Effect(Message))) {
	let route = case modem.initial_uri() {
		Ok(uri) -> routing.parse_route(uri)
		Error(_) -> routing.Index
	}

	let model = model.Model(user: auth.NotLoaded, route:, user_cli_token: "")

	let effect =
		effect.batch([
			modem.init(fn(uri) {
				uri
				|> routing.parse_route
				|> OnRouteChange
			}),
			effect.from(fn(dispatch) {
				auth.create_auth_listener(fn(user) { dispatch(OnUserChanged(user)) })
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
		OnUserChanged(user) -> model.Model(..model, user:) |> route_guard([])
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
		UserRequestedCliToken -> #(model, {
			case model.user_cli_token {
				"" -> {
					let session_token = auth.get_session_token()

					case session_token {
						Ok(token) -> get_cli_token(on_response: OnApiReturnedCliToken, token:)
						Error(_) -> effect.none()
					}
				}
				_ -> effect.none()
			}

		})

		OnApiReturnedCliToken(Ok(user_cli_token)) -> #(model.Model(..model, user_cli_token:), effect.none())
		OnApiReturnedCliToken(Error(_)) -> #(model, effect.none())
	}
}

fn view(model: Model) {
	case model.route {
		routing.Index -> routes.index_page(model)
		routing.Account -> routes.account_page(model, UserLogout)
		routing.Cli -> routes.cli_page(model, UserRequestedCliToken)
		routing.Login -> routes.login_page(model)
		routing.NotFound -> routes.not_found_page(model)
	}
}
