import app/lib/makeshift
import app/lib/renderer
import wisp

import app/routes/index
import app/routes/cli
import app/routes/account
import app/routes/login
import app/routes/not_found

pub fn handler(req: wisp.Request) {
	let assert Ok(priv) = wisp.priv_directory("app")
	use <- wisp.serve_static(req, "/", priv)

	let route = case wisp.path_segments(req) {
		[] -> Ok(index.view)
		["cli"] -> Ok(cli.view)
		["account"] -> Ok(account.view)
		["login"] -> Ok(login.view)
		_ -> Error(not_found.view)
	}

	let route_res = case route {
		Ok(route) -> {
			let context = makeshift.RouteContext(
				request: req,
				response: wisp.ok()
					|> wisp.set_header("content-type", "text/html")
			)

			route(context)
		} 
		Error(route) -> {
			let context = makeshift.RouteContext(
				request: req,
				response: wisp.not_found()
					|> wisp.set_header("content-type", "text/html")
			)

			route(context)
		}
	}

	route_res.res
	|> wisp.html_body(renderer.render(route_res.el))
}