import components/footer
import components/navbar
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub type LayoutAttrs {
	LayoutAttrs(title: String)
}

pub fn view(attrs: LayoutAttrs, children: List(Element(t))) -> Element(t) {
	let title = case attrs.title {
		"Giolt" -> "Giolt"
		title -> title <> " - Giolt"
	}

	html.html([attribute.lang("en")], [
		html.head([], [
			html.meta([attribute.charset("utf-8")]),
			html.link([
				attribute.href("/favicon.svg"),
				attribute.type_("image/svg+xml"),
				attribute.rel("icon"),
			]),
			html.meta([
				attribute.content("width=device-width, initial-scale=1.0"),
				attribute.name("viewport"),
			]),
			html.link([attribute.rel("stylesheet"), attribute.href("/app.css")]),
			html.link([
				attribute.href("https://fonts.googleapis.com"),
				attribute.rel("preconnect"),
			]),
			html.link([
				attribute.crossorigin(""),
				attribute.href("https://fonts.gstatic.com"),
				attribute.rel("preconnect"),
			]),
			html.link([
				attribute.rel("stylesheet"),
				attribute.href(
					"https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,200..800&display=swap",
				),
			]),
			html.title([], title),
		]),
		html.body([attribute.class("flex flex-col min-svh")], [
			navbar.view(),
			html.main([attribute.class("flex-1")], children),
			footer.view(),
		]),
	])
}
