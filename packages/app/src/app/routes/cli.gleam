import gleam/dict
import app/layouts/dashboard_layout
import app/lib/auth
import app/lib/db
import app/lib/makeshift
import gleam/list
import gleam/result
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
	let show_token_param = dict.get(ctx.params, "show")

	let cli_token = case show_token_param {
		Ok(_) -> {
			let user = {
				let assert auth.Authenticated(id) = ctx.session
				use result <- result.try(
					db.execute("SELECT * FROM users WHERE users.id == '" <> id <> "';")
					|> result.replace_error("Couldn't fetch user data from database"),
				)
				use user <- result.try(
					list.first(result |> db.as_user)
					|> result.replace_error("Database did not return users"),
				)

				Ok(user)
			}

			case user {
				Ok(user) -> user.cli_token
				Error(_) -> "Couldn't fetch Token"
			}
		}
		Error(_) -> ""
	}

	let is_token_shown = cli_token != ""

	let el =
		dashboard_layout.view(ctx, [], [
			h.div([a.class("container pt-2")], [
				h.div([a.class("join w-full")], [
					h.input([
						a.readonly(True),
						a.placeholder("CLI Token hidden"),
						a.class("input w-full join-item"),
						a.value(cli_token),
					]),
					h.a(
						[
							a.href("/cli" <> case is_token_shown {
								True -> ""
								False -> "?show"
							}),
							a.class("btn btn-primary join-item"),
						],
						[case is_token_shown {
							True -> h.text("Hide")
							False -> h.text("Show")
						}],
					),
					h.form([a.class("join-item"), a.method("post"), a.action("/api/rotate-cli-token")], [
						h.button(
							[
								a.type_("submit"),
								a.class("btn btn-error join-item"),
							],
							[h.text("Rotate")],
						),
					])
				]),
				h.p([a.class("mt-2 opacity-75")], [
					h.text("Use this CLI token to authenticate CLI or CI/CD requests. You can always rotate it,
						in case it gets leaked")
				])
			]),
		])

	makeshift.return(el, ctx)
}
