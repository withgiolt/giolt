import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(
	_,
	attributes: makeshift.Attributes,
	children: makeshift.Children,
) -> makeshift.Element {
	h.html([a.lang("en")], [
		h.head([], [
			h.title([], "Giolt"),
			h.link([a.rel("icon"), a.href("/favicon.svg"), a.type_("image/svg+xml")]),
			h.link([a.href("/app.css"), a.rel("stylesheet")]),
			h.link([a.rel("preconnect"), a.href("https://fonts.googleapis.com")]),
			h.link([
				a.rel("stylesheet"),
				a.href(
					"https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,200..800&display=swap",
				),
			]),
			h.script([a.src("/js/hanko.js"), a.type_("module")], ""),
		]),
		h.body(attributes, children),
	])
}
