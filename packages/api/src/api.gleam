import gleam/javascript/promise.{type Promise}
import glen.{type Request, type Response}
import glen/status

import api/routes/health
import api/routes/user/get_cli_token

pub fn handle_request(req: Request) -> Promise(Response) {
	case glen.path_segments(req) {
		[] -> health.handle_request(req)
		["health"] -> health.handle_request(req)
		["user", "get-cli-token"] -> get_cli_token.handle_request(req)
		_ -> glen.text("Not found", status.not_found) |> promise.resolve
	}
}
