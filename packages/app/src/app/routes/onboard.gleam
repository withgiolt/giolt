import app/layouts/base_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
	let el =
		base_layout.view(ctx, [], [
		  h.div([a.class("container pt-4")], [
				h.h1([a.class("text-5xl font-bold")], [h.text("Onboarding")]),
			]),
		])

	makeshift.return(el, ctx)
}
