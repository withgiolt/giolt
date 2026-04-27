import lucide_lustre
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(msg) {
	html.nav([attribute.class("navbar glass bg-base-100/50 shadow-sm")], [
		html.label(
			[
				attribute.for("main-drawer"),
				attribute.aria_label("open drawer"),
				attribute.class("btn btn-square btn-ghost lg:hidden"),
			],
			[
				lucide_lustre.panel_left_open([]),
			],
		),
	])
}
