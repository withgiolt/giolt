import gleam/erlang/process
import lib/handler
import mist
import wisp
import wisp/wisp_mist

pub fn main() -> Nil {
	wisp.configure_logger()

	let secret_key_base = wisp.random_string(64)

	let assert Ok(_) =
	  wisp_mist.handler(handler.handle_request, secret_key_base)
	  |> mist.new
	  |> mist.port(3001)
	  |> mist.start

	process.sleep_forever()
}
