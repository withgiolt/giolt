import routes/health
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
	case wisp.path_segments(req) {
		["health"] -> health.handle_request(req)
		_ -> wisp.not_found()
	}
}
