import app/layouts/base_layout
import app/lib/makeshift
import lustre/element/html as h
import lustre/attribute as a

pub fn view(ctx: makeshift.RouteContext) {
	let el = 
	base_layout.view(ctx, [], [
		h.h1([a.class("text-5xl font-bold")], [
			h.text("Onboarding the user")
		])
	])
	
	makeshift.return(el, ctx)
}