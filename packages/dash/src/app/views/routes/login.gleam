import app/model.{type Model}
import app/views/components/auth/login
import app/views/components/dynamic_logo
import lustre/attribute
import lustre/element/html

pub fn view(_model: Model) {
	html.div(
		[
			attribute.class(
				"flex flex-row h-svh",
			),
		],
		[
			html.div([], [
				html.img([
					attribute.class("object-cover w-full h-full"),
					attribute.src("/login-shapes.jpg"),
					attribute.loading("eager")
				]),
			]),
			html.div([attribute.class("flex flex-col justify-center items-center md:min-w-96")], [
				login.view([attribute.class("w-full")]),
				dynamic_logo.view([attribute.class("size-8")])
			])
		],
	)
}
