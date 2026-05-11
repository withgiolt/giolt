import app/lib/auth.{type User, type UserData}
import app/lib/routing.{type Route}
import gleam/option

pub type Model {
	Model(
		user: User,
		user_data: UserData,
		route: Route,
		error: option.Option(String),
	)
}
