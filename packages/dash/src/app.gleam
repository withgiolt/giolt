import lustre/element/html
import lustre


pub fn main() {
	let app = lustre.element(html.text("hello world"))
	let assert Ok(_) = lustre.start(app, "#app", Nil)

	Nil
}