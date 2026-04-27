import lustre/event
import lustre/element.{type Element}
import lustre/attribute
import app/model.{type Model}
import app/views/components/auth/profile
import app/views/layouts/dashboard_layout
import lustre/element/html

pub fn view(model: Model, logout_msg: msg) -> Element(msg) {

	dashboard_layout.view(model, [attribute.class("container my-4")], [
		html.h1([attribute.class("text-5xl font-bold")], [
			html.text("Account")
		]),
		html.div([attribute.class("card bg-base-200 mb-2")], [
			profile.view([]),
		]),
		html.div([attribute.class("card bg-base-200")], [
			html.button([event.on_click(logout_msg), attribute.class("btn btn-error btn-soft")], [
				html.text("Log out")
			])
		])
	])
}
