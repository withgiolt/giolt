import app/lib/auth.{type User}
import app/lib/routing.{type Route}

pub type Model {
	Model(
		user: User,
		route: Route
	)
}