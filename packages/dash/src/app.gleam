import gleam/javascript/promise
import modem
import app/lib/auth
import lustre
import lustre/effect.{type Effect}

import app/model.{type Model}

// Routing
import app/lib/routing
import app/lib/routing/route_guard.{route_guard}
import app/lib/routing/routes


pub fn main() {
	use init <- promise.await(init(Nil))
	let app = lustre.application(fn (_) { init }, update, view)
	let assert Ok(_) = lustre.start(app, "#app", Nil)

	promise.resolve(Nil)
}

type Message {
	OnRouteChange(routing.Route)
	OnUserChanged(auth.User)
}

fn init(_) -> promise.Promise(#(Model, Effect(Message))) {
	let route = case modem.initial_uri() {
		Ok(uri) -> routing.parse_route(uri)
		Error(_) -> routing.Index
	}

	let model = model.Model(user: auth.NotLoaded, route:)

	let effect = effect.batch([
		modem.init(fn (uri) {
			uri
			|> routing.parse_route
			|> OnRouteChange
		}),
		effect.from(fn (dispatch) {
			promise.await(auth.validate_session(), fn(user) {
				dispatch(OnUserChanged(user))
				promise.resolve(Nil)
			})
			Nil
		})
	])

	promise.resolve(#(model, effect))
}

fn update(model: Model, msg: Message) -> #(Model, Effect(Message)) {
	case msg {
		OnUserChanged(user) -> model.Model(..model, user:) |> route_guard
		OnRouteChange(route) -> model.Model(..model, route:) |> route_guard
	}
}

fn view(model: Model) {
	case model.route {
		routing.Index -> routes.index_page(model)
		routing.Login -> routes.login_page(model)
	}
}