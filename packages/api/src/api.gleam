import gleam/javascript/promise.{type Promise}
import glen.{type Request, type Response}
import glen/status

import api/routes/health
import api/routes/user

pub fn handle_request(req: Request) -> Promise(Response) {
	case glen.path_segments(req) {
		[] -> health.handle_request(req)
		["api", "health"] -> health.handle_request(req)
		["api", "user"] -> user.handle_request(req)
		_ -> glen.text("Not found", status.not_found) |> promise.resolve
	}
}
