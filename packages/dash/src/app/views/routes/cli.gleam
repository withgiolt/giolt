import lustre/event
import gleam/string
import app/model.{type Model}
import app/views/layouts/dashboard_layout
import lustre/attribute
import lustre/element/html

pub fn view(model: Model, get_cli_token_msg: msg) {
	dashboard_layout.view(model, [], [
		html.div([attribute.class("container")], [
			html.div([attribute.class("join w-full")], [
				html.button([
					attribute.disabled(!string.is_empty(model.user_cli_token)),
					attribute.class("btn btn-primary join-item"),
					event.on_click(get_cli_token_msg)
				], [
					html.text("Get CLI Token")
				]),
				html.input([
					attribute.readonly(True),
					attribute.placeholder("CLI Token hidden"),
					attribute.class("input w-full join-item"),
					attribute.value(model.user_cli_token)
				])
			])
		]),
	])
}
