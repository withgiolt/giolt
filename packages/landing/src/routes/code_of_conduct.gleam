import layouts/default_layout
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html
import mork
import simplifile

pub fn view() -> Element(t) {
  let assert Ok(markdown) = simplifile.read("../../CODE_OF_CONDUCT.md")
  let html =
    markdown
    |> mork.parse
    |> mork.to_html

  default_layout.view(default_layout.LayoutAttrs("Code of Conduct"), [
    html.div([attribute.class("container")], [
      element.unsafe_raw_html("", "div", [attribute.class("prose")], html),
    ]),
  ])
}
