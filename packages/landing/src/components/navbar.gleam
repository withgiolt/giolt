import components/dynamic_logo
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
	element.fragment([
		html.nav([attribute.class("navbar mb-4")], []),
		html.nav(
			[
				attribute.class(
					"navbar top-0 left-0 right-0 fixed glass bg-base-100/50 shadow-sm z-50 px-0",
				),
			],
			[
				html.div(
					[attribute.class("container flex-1 flex flex-row items-center gap-1")],
					[
						html.a(
							[
								attribute.class("btn btn-ghost btn-circle"),
								attribute.aria_label("Logo"),
								attribute.href("/"),
							],
							[dynamic_logo.view()],
						),
					],
				),
			],
		),
	])
}
