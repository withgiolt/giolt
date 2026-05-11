import app/lib/router
import envie
import gleam/erlang/process
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  let assert Ok(Nil) = envie.load()
  let assert Ok(_) = start_server(fn(h) { h })
  process.sleep_forever()
}

pub fn start_server(wrap_reload) {
  let secret_key_base = wisp.random_string(64)

  wisp_mist.handler(router.handler, secret_key_base)
  |> wrap_reload()
  |> mist.new
  |> mist.port(envie.get_int("PORT", 3000))
  |> mist.start
}
