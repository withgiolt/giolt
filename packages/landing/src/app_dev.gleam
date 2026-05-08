import gleam/list
import build
import gleam/erlang/process
import gleamyshell
import lustre/element
import lustre/element/html
import mist
import mist/reload
import wisp
import wisp/wisp_mist


pub fn main() {
	process.spawn(fn() { gleamyshell.execute("bun", ".", ["dev:compile:css"]) })

	let secret_key_base = wisp.random_string(32)
	let assert Ok(_) =
		wisp_mist.handler(handler, secret_key_base)
		|> reload.wrap
		|> mist.new
		|> mist.port(3000)
		|> mist.start

	process.sleep_forever()
}

fn handler(req: wisp.Request) {
	let assert Ok(priv) = wisp.priv_directory("app")
	use <- wisp.serve_static(req, "/", priv)

	let html = {
		let route = list.key_find(build.routes, wisp.path_segments(req))
		
		case route {
			Ok(route) -> route()
			Error(_) -> html.html([], [html.script([], "window.location.replace('/');")])
		}
	} |> element.to_document_string

	wisp.html_response(html, 200)
}
