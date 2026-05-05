import app/model.{type Model}
import app/views/layouts/dashboard_layout
import lustre/attribute
import lustre/element/html

pub fn view(model: Model) {
	dashboard_layout.view(model, [], [
		html.div([attribute.class("container")], [html.text("hello")]),
	])
}
