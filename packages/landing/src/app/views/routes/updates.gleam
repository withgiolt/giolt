import app/views/layouts/default_layout
import gleam/list
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import mork
import simplifile

pub fn view() -> Element(t) {
	let assert Ok(files_paths) = simplifile.read_directory("./src/content")

	let files =
		list.map(files_paths, fn(path) {
			let assert Ok(file) = simplifile.read("./src/content/" <> path)
			file
		})

	let markdown_contents =
		list.map(files, fn(file) {
			let content =
				file
				|> mork.parse
				|> mork.to_html

			content
		})

	default_layout.view(default_layout.LayoutAttrs("Updates"), [
		html.div([attribute.class("container")], [
			html.h1([attribute.class("text-5xl font-bold mb-4")], [
				html.text("Updates"),
			]),
			html.div([], {
				list.map(markdown_contents, fn(post) {
					html.div([], [
						element.unsafe_raw_html(
							"",
							"div",
							[attribute.class("prose card p-4 bg-base-200")],
							post,
						),
					])
				})
			}),
		]),
	])
}
