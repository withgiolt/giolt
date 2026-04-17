import gleam/erlang/process
import mist
import routes/health
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() -> Nil {
	wisp.configure_logger()

	let secret_key_base = wisp.random_string(64)

	let assert Ok(_) =
		wisp_mist.handler(handle_request, secret_key_base)
		|> mist.new
		|> mist.port(3001)
		|> mist.start

	process.sleep_forever()
}

pub fn handle_request(req: Request) -> Response {
	case wisp.path_segments(req) {
		[] -> health.handle_request(req)
		["health"] -> health.handle_request(req)
		_ -> wisp.not_found()
	}
}
