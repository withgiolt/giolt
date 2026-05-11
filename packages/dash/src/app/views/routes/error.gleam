import lustre/attribute
import lustre/element/html

pub fn view(_: model, reason: String) {
	html.div([attribute.class("container text-center pt-24 space-y-2")], [
		html.h1([attribute.class("text-5xl font-bold")], [html.text("Oops!")]),
		html.p([], [
			html.text(
				"We ran into a problem and can't recover. Refreshing this page might help.",
			),
		]),
		html.p([], [html.text("Reason: \"" <> reason <> "\"")]),
		html.button(
			[
				attribute.class("btn btn-primary"),
				attribute.attribute("onclick", "window.location.reload()"),
			],
			[html.text("Refresh")],
		),
	])
}
