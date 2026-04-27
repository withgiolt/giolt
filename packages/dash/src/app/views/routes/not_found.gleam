import app/model.{type Model}
import lustre/attribute
import lustre/element/html

pub fn view(_model: Model) {
	html.div(
		[
			attribute.class(
				"flex flex-col justify-center items-center container h-1/2",
			),
		],
		[html.h1([], [html.text("Not Found")])],
	)
}
