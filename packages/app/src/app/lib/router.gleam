import app/lib/auth
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

	let route = route_handler(req)

	case route {
		Ok(route) -> route.res |> wisp.html_body(renderer.render(route.el))
		Error(_) -> wisp.html_response("<h1>Very bad man</h1>", 500)
	}
}

fn route_handler(req: wisp.Request) {
	let session = auth.get_session(req)

	let route = case wisp.path_segments(req) {
		[] -> index.view
		["cli"] -> cli.view
		["account"] -> account.view
		["login"] -> login.view
		_ -> not_found.view
	}

	case session {
		Ok(session) -> {
			let context = makeshift.RouteContext(
				session:,
				request: req,
				response: wisp.ok()
					|> wisp.set_header("content-type", "text/html")
			) |> route_guard

			route(context)
		} 
		Error(_) -> {
			let context = makeshift.RouteContext(
				session: auth.Unauthenticated,
				request: req,
				response: wisp.not_found()
					|> wisp.set_header("content-type", "text/html")
			)

			route(context)
		}
	}
}

fn route_guard(ctx: makeshift.RouteContext) -> makeshift.RouteContext {
	case ctx.session {
		auth.Authenticated(..) -> case wisp.path_segments(ctx.request) {
			["login"] -> ctx |> makeshift.redirect_to("/")
			_ -> ctx
		}
		auth.Unauthenticated -> case wisp.path_segments(ctx.request) {
			["login"] -> ctx
			_ -> ctx |> makeshift.redirect_to("/login")
		}
	}
}