import lustre/element/html
import lustre/element
import build
import filespy
import gleam/erlang/process
import gleamyshell
import mist
import wisp/wisp_mist
import mist/reload
import wisp

import app/routes/code_of_conduct
import app/routes/index
import app/routes/updates

pub fn main() {
	build.build()
	
	process.spawn(fn() { gleamyshell.execute("bun", ".", ["dev:compile:css"]) })
	let _ = filespy.new()
	|> filespy.add_dir("./src")
	|> filespy.set_handler(fn (_, _) {
		build.build()
	})
	|> filespy.start()

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

	let html = element.to_document_string(
		case wisp.path_segments(req) {
			[] -> index.view()
			["code-of-conduct"] -> code_of_conduct.view()
			["updates"] -> updates.view()
			_ -> html.html([], [html.script([], "window.location.replace('/');")])
		}
	)

	wisp.html_response(html, 200)
}