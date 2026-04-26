import app/lib/routing
import lustre/effect.{type Effect}
import modem
import gleam/option
import app/lib/auth
import app/model.{type Model}

pub fn route_guard(model: Model) -> #(Model, Effect(t)) {
	case model.user {
		auth.User(..) -> {
			case model.route {
				routing.Login -> 
					#(
						model.Model(..model, route: routing.Index),
						modem.replace("/", option.None, option.None)
					)
				_ -> #(model, effect.none())
			}
		}
		auth.NoUser -> 
			case model.route {
				routing.Login -> #(model, effect.none())
				_ -> 
					#(
						model.Model(..model, route: routing.Login),
						modem.replace("/login", option.None, option.None)
					)
			}
		_ -> #(model, effect.none())
	}
}