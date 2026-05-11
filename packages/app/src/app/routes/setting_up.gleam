import app/lib/auth
import gleam/erlang/process
import app/lib/db
import app/layouts/base_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

fn create_user(id: String) {
	db.execute("INSERT INTO users (id) VALUES ('" <> id <> "');")
}

pub fn view(ctx: makeshift.RouteContext) {
	let assert auth.Authenticated(session) = ctx.session
	process.spawn(fn () {create_user(session)})

	let el =
		base_layout.view(ctx, [], [
			h.div([a.class("container my-4")], [
				h.h1([a.class("text-5xl font-bold")], [h.text("Just a second")]),
				h.p([], [h.text("We are setting up your account")]),
				h.p([], [
					h.text("If the page doesn't reload after 5 seconds, "),
					h.a([a.href("/"), a.class("link")], [h.text("Click here")]),
					h.text(" to reload")
				])
			]),
			h.script([], "
				setTimeout(() => { window.location.href = \"/\" }, 5000)
			")
		])

	makeshift.return(el, ctx)
}
