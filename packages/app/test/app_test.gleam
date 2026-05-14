import envie
import gleam/dynamic/decode
import gleam/erlang/process
import gleam/http/request
import gleam/httpc
import gleamyshell
import gleeunit
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  envie.set("AUTH_URL", "http://localhost:3001")
  envie.set("DATABASE_URL", "http://localhost:3002")
  process.spawn(start_mock_auth_api)
  process.spawn(start_mock_libsql_database)

  await_libsql_database()

  gleeunit.main()

  kill_libsql_database()
}

fn start_mock_auth_api() {
  let secret_key_base = wisp.random_string(64)

  let _ =
    wisp_mist.handler(mock_auth_api_handler, secret_key_base)
    |> mist.new
    |> mist.port(3001)
    |> mist.start

  process.sleep_forever()
}

fn mock_auth_api_handler(req: wisp.Request) {
  use body <- wisp.require_json(req)

  let session_token =
    decode.run(body, {
      use session_token <- decode.field("session_token", decode.string)

      decode.success(session_token)
    })

  case session_token {
    Ok(_) -> {
      wisp.ok()
      |> wisp.json_body(
        "{ \"is_valid\": true, \"claims\": { \"subject\": \"user-id\" }}",
      )
    }
    Error(_) -> {
      wisp.bad_request("No cookie")
    }
  }
}

fn start_mock_libsql_database() {
  let _ =
    gleamyshell.execute("turso", ".", ["dev", "-f=../../local.db", "-p=3002"])

  process.sleep_forever()
}

fn await_libsql_database() {
  let assert Ok(req) = request.to("http://localhost:3002/v2/pipeline")
  let res = httpc.send(req)

  case res {
    Ok(_) -> Nil
    Error(_) -> await_libsql_database()
  }
}

fn kill_libsql_database() {
  let _ = gleamyshell.execute("killall", ".", ["-9", "sqld"])

  Nil
}
