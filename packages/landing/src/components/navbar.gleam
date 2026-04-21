import components/dynamic_logo
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
	html.nav(
		[
			attribute.class(
				"navbar top-0 left-0 right-0 fixed glass bg-base-100/50 shadow-sm z-50 px-4",
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
							attribute.href("{logoHref}"),
						],
						[dynamic_logo.view()],
					),
					html.span([attribute.class("badge badge-sm badge-soft")], [
						html.text(" Alpha "),
					]),
				],
			),
		],
	)
}
