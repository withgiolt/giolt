import gleam/option
import app/lib/db
import app/lib/auth
import app/lib/makeshift
import app/lib/renderer
import wisp

import app/routes/index
import app/routes/cli
import app/routes/account
import app/routes/login
import app/routes/onboard
import app/routes/api/onboard_api
import app/routes/not_found

pub fn handler(req: wisp.Request) {
	let assert Ok(priv) = wisp.priv_directory("app")
	use <- wisp.serve_static(req, "/", priv)

	let api_route = api_route_handler(req)
	case api_route {
		Ok(api_route) -> {
			case api_route {
				Ok(api_route) -> api_route
				Error(_) -> wisp.html_response("<h1>Very bad man</h1>", 500)
			}
		}
		// Fallback to pages
		Error(_) -> {
			let route = route_handler(req)

			case route {
				Ok(route) -> route.res |> wisp.html_body(renderer.render(route.el))
				Error(_) -> wisp.html_response("<h1>Very bad man</h1>", 500)
			}
		}
	}

}

fn api_route_handler(req: wisp.Request) {
	let session = auth.get_session(req)

	let route = case wisp.path_segments(req) {
		["api", "onboard"] -> option.Some(onboard_api.handler)
		_ -> option.None
	}

	case route {
		option.Some(handler) -> {
			let context = makeshift.RouteContext(
				session: case session {
					Ok(session) -> session
					Error(_) -> auth.Unauthenticated
				},
				request: req,
				response: wisp.ok()
					|> wisp.set_header("content-type", "text/html")
			)

			Ok(handler(context))
		}
		option.None -> Error("No API Route")
	}
}

fn route_handler(req: wisp.Request) {
	let session = auth.get_session(req)

	let route = case wisp.path_segments(req) {
		[] -> index.view
		["cli"] -> cli.view
		["account"] -> account.view
		["login"] -> login.view
		["onboard"] -> onboard.view
		_ -> not_found.view
	} 

	
	let context = makeshift.RouteContext(
		session: case session {
			Ok(session) -> session
			Error(_) -> auth.Unauthenticated
		},
		request: req,
		response: wisp.ok()
			|> wisp.set_header("content-type", "text/html")
	) |> route_guard

	route(context)
}

fn route_guard(ctx: makeshift.RouteContext) -> makeshift.RouteContext {
	case ctx.session {
		auth.Authenticated(id) -> case wisp.path_segments(ctx.request) {
			["login"] -> ctx |> makeshift.redirect_to("/")
			path -> {
				let res = db.execute("SELECT id FROM users WHERE users.id == '" <> id <> "';")
			
				case res {
					Ok(res) -> case res, path {
						[], ["onboard"] -> ctx // No user and on onboard page
						[_, ..], ["onboard"] -> ctx |> makeshift.redirect_to("/") // Has user and on onboard page
						[], _ -> ctx |> makeshift.redirect_to("/onboard") // No user and is anywhere
						[_, ..], _ -> ctx // Has user and is anywhere
					}
					Error(_) if path != ["error"] -> ctx |> makeshift.redirect_to("/error")
					Error(_) -> ctx
				}
			}
		}
		auth.Unauthenticated -> case wisp.path_segments(ctx.request) {
			["login"] -> ctx
			_ -> ctx |> makeshift.redirect_to("/login")
		}
	}
}