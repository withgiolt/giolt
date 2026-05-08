import app/lib/makeshift
import app/components/auth/profile
import app/layouts/dashboard_layout
import lustre/attribute
import lustre/element/html

pub fn view(ctx: makeshift.RouteContext) -> makeshift.RouteResponse {
	let el = 
	dashboard_layout.view(ctx, [attribute.class("container my-4")], [
		html.h1([attribute.class("text-5xl font-bold")], [html.text("Account")]),
		html.div([attribute.class("card bg-base-200 mb-2")], [
			profile.view([]),
		]),
		html.div([attribute.class("card bg-base-200")], [
			html.button(
				[attribute.class("btn btn-error btn-soft")],
				[html.text("Log out")],
			),
		]),
	])

	makeshift.return(el, ctx)
}
