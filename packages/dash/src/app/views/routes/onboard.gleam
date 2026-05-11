import lustre/attribute
import lustre/element/html

pub fn view(_: model) {
	html.div([attribute.class("container text-center pt-24 space-y-2")], [
		html.h1([attribute.class("text-5xl font-bold")], [html.text("Onboarding!")]),
	])
}
