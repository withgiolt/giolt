import lustre/element/html
import lustre/element
import gleam/io
import gleam/result
import gleam/string
import lib/execute
import lustre/ssg

import routes/index

pub fn main() {
  let build =
    ssg.new("./dist")
    |> ssg.add_static_asset(
      "/index.html",
      element.to_document_string(index.view())
    )
    |> ssg.add_static_route("/404", html.html([], [html.script([], "window.location.replace('/');")]))
    |> ssg.add_static_dir("./static")
    |> ssg.build
    |> result.map_error(fn(e) { string.inspect(e) })
    |> result.try(fn(_) {
      execute.execute(
        "bunx @tailwindcss/cli -i ./src/assets/app.css -o ./dist/app.css",
      )

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
