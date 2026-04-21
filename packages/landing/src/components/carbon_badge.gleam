import gleam/int
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
	let cleaner_than = 98
	let score = "A+"

	html.a([attribute.href("https://www.websitecarbon.com/website/giolt-com/")], [
		html.span([attribute.class("badge badge-outline")], [
			html.text(
				"Cleaner than " <> int.to_string(cleaner_than) <> "% of all sites ",
			),
		]),
		html.span([attribute.class("badge badge-outline")], [
			html.text(score <> " Carbon Rating "),
		]),
	])
}
