import gleam/int
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
	let cleaner_than = 97
	let score = "A+"

	html.a(
		[
			attribute.href("https://www.websitecarbon.com/website/giolt-com/"),
			attribute.target("_blank"),
		],
		[
			html.span([attribute.class("badge badge-outline m-0.5")], [
				html.text(
					"Cleaner than " <> int.to_string(cleaner_than) <> "% of all sites ",
				),
			]),
			html.span([attribute.class("badge badge-outline m-0.5")], [
				html.text(score <> " Carbon Rating "),
			]),
		],
	)
}
