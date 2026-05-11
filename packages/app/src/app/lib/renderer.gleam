import gleam/string_tree
import lustre/element.{type Element}

pub fn render(el: Element(t)) {
	element.to_document_string_tree(el)
	|> string_tree.to_string
}
