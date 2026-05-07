import app/lib/makeshift
import app/lib/renderer
import gleam/list
import wisp

import app/routes/index
import app/routes/not_found

const routes = [
	#([], index.view)
]

pub fn handler(req: wisp.Request) {
	let assert Ok(priv) = wisp.priv_directory("app")
	use <- wisp.serve_static(req, "/", priv)
	let route = list.key_find(routes, wisp.path_segments(req))

	let route_res = case route {
		Ok(route) -> {
			let context = makeshift.RouteContext(
				request: req,
				response: wisp.ok()
					|> wisp.set_header("content-type", "text/html")
			)

			route(context)
		} 
		Error(_) -> {
			let context = makeshift.RouteContext(
				request: req,
				response: wisp.not_found()
					|> wisp.set_header("content-type", "text/html")
			)

			not_found.view(context)
		}
	}

	route_res.res
	|> wisp.html_body(renderer.render(route_res.el))
}