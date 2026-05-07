import app/lib/makeshift
import lustre/element/html as h
import lustre/attribute as a

pub fn view(_attr: makeshift.Attributes, children: makeshift.Children) -> makeshift.Element {
	h.html([a.lang("en")], [
		h.head([], [
			h.title([], "Giolt"),
			h.link([a.href("/app.css"), a.rel("stylesheet")])
		]),
		h.body([], children)
	])
}