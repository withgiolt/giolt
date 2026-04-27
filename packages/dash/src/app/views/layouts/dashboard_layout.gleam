import app/lib/routing
import app/model
import app/views/components/dashboard_nav
import gleam/list
import lucide_lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(
	model: model.Model,
	attributes: List(attribute.Attribute(msg)),
	children: List(Element(msg)),
) -> Element(msg) {
	let menu_items = [
		#(lucide_lustre.grid_2x2, "Projects", routing.Index),
		#(lucide_lustre.circle_user, "Account", routing.Account),
	]

	html.div([attribute.class("drawer lg:drawer-open")], [
		html.input([
			attribute.id("main-drawer"),
			attribute.type_("checkbox"),
			attribute.class("drawer-toggle"),
		]),
		html.div([attribute.class("drawer-content")], [
			dashboard_nav.view(),
			html.div(attributes, children),
		]),

		html.div([attribute.class("drawer-side")], [
			html.label(
				[
					attribute.for("main-drawer"),
					attribute.aria_label("close sidebar"),
					attribute.class("drawer-overlay"),
				],
				[],
			),
			html.div(
				[
					attribute.class(
						"flex min-h-full flex-col items-start bg-base-200 w-64",
					),
				],
				[
					html.ul(
						[attribute.class("menu w-full grow")],
						list.map(menu_items, fn(item) {
							html.li([], [
								html.a(
									[
										routing.href(item.2),
										attribute.attribute("onclick", "document.getElementById(\"main-drawer\").checked = false"),
										attribute.classes([#("menu-active", model.route == item.2)]),
									],
									[
										item.0([attribute.class("inline-block size-4")]),
										html.span([], [
											html.text(item.1),
										]),
									],
								),
							])
						}),
					),
				],
			),
		]),
	])
}
