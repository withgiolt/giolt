import app/views/auth/login
import app/lib/auth
import app/model.{type Model}
import lustre/element/html

pub fn view(model: Model) {
	echo model

	html.div([], [
		html.text(
			case model.user {
				auth.User(..) -> "Authed"
				auth.NoUser -> "Not authed"
				auth.NotLoaded -> "Loading"
			}
		),
		login.view([])
	])
}