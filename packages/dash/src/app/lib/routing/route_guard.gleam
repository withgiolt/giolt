import app/lib/auth
import app/lib/routing
import app/model.{type Model}
import gleam/option
import lustre/effect.{type Effect}
import modem

pub fn route_guard(
	model: Model,
	effects: List(Effect(msg)),
) -> #(Model, Effect(msg)) {
	case model.user {
		auth.User(..) -> {
			case model.route {
				routing.Login -> #(
					model.Model(..model, route: routing.Index),
					effect.batch([modem.replace("/", option.None, option.None), ..effects]),
				)
				_ -> #(model, effect.batch([effect.none(), ..effects]))
			}
		}
		auth.NoUser ->
			case model.route {
				routing.Login -> #(model, effect.none())
				_ -> #(
					model.Model(..model, route: routing.Login),
					effect.batch([
						modem.replace("/login", option.None, option.None),
						..effects
					]),
				)
			}
		_ -> #(model, effect.batch([effect.none(), ..effects]))
	}
}
