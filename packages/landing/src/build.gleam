import gleam/list
import gleam/io
import gleam/result
import gleam/string
import gleamyshell
import lustre/element
import lustre/element/html
import lustre/ssg

import app/routes/code_of_conduct
import app/routes/index
import app/routes/updates

pub fn main() {
	let _ = gleamyshell.execute("bun", ".", ["compile:css"])
	build()
}

pub const routes = [
	#([], index.view),
	#(["code-of-conduct"], code_of_conduct.view),
	#(["updates"], updates.view),
]

fn add_routes(
	config: ssg.Config(ssg.NoStaticRoutes, ssg.NoStaticDir, ssg.UseDirectRoutes),
	routes: List(#(List(String), fn () -> element.Element(t)))
) {
	case routes {
		[] -> config
		[#(key, value), ..rest] -> add_routes(ssg.add_static_asset(config, "/" <> string.join(list.append(key, ["index.html"]), "/"), element.to_document_string(value())), rest)
	}
}

pub fn build() {
	let build =
		ssg.new("./dist")
		|> add_routes(routes)
		|> ssg.add_static_route(
			"/404",
			html.html([], [html.script([], "window.location.replace('/');")]),
		)
		|> ssg.add_static_dir("./priv")
		|> ssg.build
		|> result.map_error(fn(e) { string.inspect(e) })

	case build {
		Ok(_) -> io.println("Build succeeded!")
		Error(e) -> {
			echo e
			io.println("Build failed!")
		}
	}
}
