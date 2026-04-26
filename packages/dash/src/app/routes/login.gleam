import lustre/attribute
import app/views/auth/login
import app/model.{type Model}
import lustre/element/html

pub fn view(_model: Model) {
	html.div([attribute.class("flex flex-col justify-center items-center container h-1/2")], [
		login.view([attribute.class("w-[410px]")])
	])
}