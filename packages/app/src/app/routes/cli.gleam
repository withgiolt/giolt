import app/lib/makeshift
import app/layouts/dashboard_layout
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
	let el =
	dashboard_layout.view(ctx, [], [
		h.div([a.class("container")], [
			h.div([a.class("join w-full")], [
				h.input([
					a.readonly(True),
					a.placeholder("CLI Token hidden"),
					a.class("input w-full join-item"),
				]),
				h.button([
					a.class("btn btn-primary join-item"),
				], [
					h.text("Copy")
				])
			])
		]),
	])

	makeshift.return(el, ctx)
}
