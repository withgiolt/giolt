import envie
import gleam/dynamic/decode
import gleam/erlang/process
import gleam/http
import gleam/http/request
import gleam/httpc
import gleam/list
import gleamyshell
import gleeunit
import mist
import wisp
import wisp/wisp_mist

pub fn main() {
  envie.set("AUTH_URL", "http://localhost:3001")
  envie.set("DATABASE_URL", "http://localhost:3002")
  envie.set("BUNNY_API_URL", "http://localhost:3003")
  envie.set("BUNNY_API_KEY", "bunny-key")
  envie.set("BUNNY_STORAGE_ZONE_ID", "12345")
  process.spawn(start_mock_auth_api)
  process.spawn(start_mock_bunny_api)
  process.spawn(start_mock_libsql_database)

  await_mock_libsql_database()

  gleeunit.main()

  kill_mock_libsql_database()
}

fn start_mock_bunny_api() {
  let secret_key_base = wisp.random_string(64)

  let _ =
    wisp_mist.handler(mock_bunny_api_handler, secret_key_base)
    |> mist.new
    |> mist.port(3003)
    |> mist.start

  process.sleep_forever()
}

fn mock_bunny_api_handler(req: wisp.Request) {
  //   use _ <- wisp.require_json(req)
  let key = list.key_find(req.headers, "accesskey")

  case key {
    Ok(_) -> {
      case wisp.path_segments(req), req.method {
        ["pullzone"], http.Post -> wisp.json_response("{ \"Id\": 1000 }", 201)
        ["pullzone", _], http.Delete -> wisp.response(204)
        _, _ -> wisp.bad_request("Invalid request path or method")
      }
    }
    Error(_) -> wisp.bad_request("Invalid AccessKey")
  }
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

fn await_mock_libsql_database() {
  let assert Ok(req) = request.to("http://localhost:3002/v2/pipeline")
  let res = httpc.send(req)

  case res {
    Ok(_) -> Nil
    Error(_) -> await_mock_libsql_database()
  }
}

fn kill_mock_libsql_database() {
  let _ = gleamyshell.execute("killall", ".", ["-9", "sqld"])

  Nil
}
