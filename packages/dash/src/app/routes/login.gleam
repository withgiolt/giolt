import lustre/element
import app/model.{type Model}
import lustre/element/html

pub fn view(_model: Model) {
	html.div([], [
		element.element("hanko-auth", [], [])
	])
}