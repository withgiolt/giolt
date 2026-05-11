import app/layouts/dashboard_layout
import app/lib/auth
import app/lib/db
import app/lib/makeshift
import gleam/list
import gleam/result
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
	let assert auth.Authenticated(id) = ctx.session
	use result <- result.try(
		db.execute("SELECT * FROM users WHERE users.id == '" <> id <> "';")
		|> result.replace_error("Couldn't fetch user data from database"),
	)
	use user <- result.try(
		list.first(result |> db.as_user)
		|> result.replace_error("Database did not return users"),
	)

	let el =
		dashboard_layout.view(ctx, [], [
			h.div([a.class("container")], [
				h.div([a.class("join w-full")], [
					h.input([
						a.readonly(True),
						a.placeholder("CLI Token hidden"),
						a.class("input w-full join-item"),
						a.value(user.cli_token),
					]),
					h.button(
						[
							a.class("btn btn-primary join-item"),
						],
						[h.text("Copy")],
					),
				]),
			]),
		])

	makeshift.return(el, ctx)
}
