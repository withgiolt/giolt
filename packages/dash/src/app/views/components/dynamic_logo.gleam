import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view(attributes: List(attribute.Attribute(t))) -> Element(t) {
	html.div([attribute.class("grid relative bg-[#E6E4E3] rounded-full group"), ..attributes], [
		html.img([
			attribute.class(
				"absolute p-1 group-hover:animate-[spin_2s_linear_infinite]",
			),
			attribute.alt("Giolt Logo"),
			attribute.src("/logo-transparent-star.svg"),
		]),
		html.img([
			attribute.class("relative p-1"),
			attribute.alt(""),
			attribute.src("/logo-transparent-g.svg"),
		]),
	])
}
