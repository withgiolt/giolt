import app/layouts/dashboard_layout
import app/lib/makeshift
import lustre/element/html as h
import lustre/attribute as a

pub fn view(ctx: makeshift.RouteContext) {
	let el =
	dashboard_layout.view(ctx, [], [
		h.p([], [h.text("We are working in Gleam! Completely server-side. No javascript.")]),
		h.button([a.class("btn btn-primary")], [h.text("Hello world!")]),
	])

	makeshift.return(el, ctx)
}