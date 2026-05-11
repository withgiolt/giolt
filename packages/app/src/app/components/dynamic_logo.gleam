import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(attributes: makeshift.Attributes) -> makeshift.Element {
	h.div(
		[a.class("grid relative bg-[#E6E4E3] rounded-full group"), ..attributes],
		[
			h.img([
				a.class("absolute p-1 group-hover:animate-[spin_2s_linear_infinite]"),
				a.alt("Giolt Logo"),
				a.src("/logo-transparent-star.svg"),
			]),
			h.img([
				a.class("relative p-1"),
				a.alt(""),
				a.src("/logo-transparent-g.svg"),
			]),
		],
	)
}
