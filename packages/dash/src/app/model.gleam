import app/lib/auth.{type User, type UserData}
import app/lib/routing.{type Route}

pub type Model {
	Model(
		user: User,
		user_data: UserData,
		route: Route
	)
}
