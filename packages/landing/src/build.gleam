import app/dev/fs
import gleam/io
import gleam/result
import gleam/string
import lustre/element
import lustre/element/html
import lustre/ssg

import app/routes/code_of_conduct
import app/routes/index
import app/routes/updates

pub fn main() {
  let build =
    ssg.new("./dist")
    |> ssg.add_static_asset(
      "/index/index.html",
      element.to_document_string(index.view()),
    )
    |> ssg.add_static_asset(
      "/updates/index.html",
      element.to_document_string(updates.view()),
    )
    |> ssg.add_static_asset(
      "/code-of-conduct/index.html",
      element.to_document_string(code_of_conduct.view()),
    )
    |> ssg.add_static_route(
      "/404",
      html.html([], [html.script([], "window.location.replace('/');")]),
    )
    |> ssg.add_static_dir("./static")
    |> ssg.build
    |> result.map_error(fn(e) { string.inspect(e) })
    |> result.try(fn(_) {
      fs.execute("bun compile:css")

      Ok(Nil)
    })

  case build {
    Ok(_) -> io.println("Build succeeded!")
    Error(e) -> {
      echo e
      io.println("Build failed!")
    }
  }
}
