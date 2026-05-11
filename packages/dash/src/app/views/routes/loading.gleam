import lustre/attribute
import lustre/element/html

pub fn view() {
	html.div([attribute.class("container text-center pt-24 space-y-2")], [
		html.h1([attribute.class("text-4xl font-bold")], [html.text("Loading...")]),
	])
}
