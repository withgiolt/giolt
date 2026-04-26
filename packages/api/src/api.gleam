import gleam/javascript/promise.{type Promise}
import glen.{type Request, type Response}
import glen/status
import api/lib/auth

import api/routes/auth_reference
import api/routes/health

pub fn handle_request(req: Request) -> Promise(Response) {
	case glen.path_segments(req) {
		[] -> health.handle_request(req)
		["health"] -> health.handle_request(req)
		["auth", "reference"] -> auth_reference.handle_request(req)
		["auth", ..] -> {
			echo auth.handle_requests(auth.get_auth(), req)
			auth.handle_requests(auth.get_auth(), req)
		}
		_ -> glen.text("Not found", status.not_found) |> promise.resolve
	}
}
