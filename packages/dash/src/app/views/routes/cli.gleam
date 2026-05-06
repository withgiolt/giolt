import app/lib/auth
import app/model.{type Model}
import app/views/layouts/dashboard_layout
import lustre/attribute
import lustre/element/html

pub fn view(model: Model) {
	dashboard_layout.view(model, [], [
		html.div([attribute.class("container")], [
			html.div([attribute.class("join w-full")], [
				html.input([
					attribute.readonly(True),
					attribute.placeholder("CLI Token hidden"),
					attribute.class("input w-full join-item"),
					attribute.value(case model.user_data {
						auth.UserData(cli_token) -> cli_token
						_ -> "Loading CLI Token"
					})
				]),
				html.button([
					attribute.class("btn btn-primary join-item"),
				], [
					html.text("Copy")
				])
			])
		]),
	])
}
