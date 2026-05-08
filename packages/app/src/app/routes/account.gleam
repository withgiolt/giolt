import app/lib/makeshift
import app/components/auth/profile
import app/layouts/dashboard_layout
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
	let el = 
	dashboard_layout.view(ctx, [a.class("container my-4")], [
		h.h1([a.class("text-5xl font-bold")], [h.text("Account")]),
		h.div([a.class("card bg-base-200 mb-2")], [
			profile.view([]),
		]),
		h.div([a.class("card bg-base-200"), a.id("hanko-logout")], [
			h.button(
				[a.class("btn btn-error btn-soft")],
				[h.text("Log out")],
			),
		]),
	])

	makeshift.return(el, ctx)
}
