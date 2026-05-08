import app/lib/makeshift
import lucide_lustre
import lustre/attribute as a
import lustre/element/html as h

pub fn view(_, _) -> makeshift.Element {
	h.nav([a.class("navbar glass bg-base-100/50 shadow-sm")], [
		h.label(
			[
				a.for("main-drawer"),
				a.aria_label("open drawer"),
				a.class("btn btn-square btn-ghost lg:hidden"),
			],
			[
				lucide_lustre.panel_left_open([]),
			],
		),
	])
}
