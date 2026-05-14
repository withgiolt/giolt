import app/lib/utils
import envie
import gleam/dynamic/decode
import gleam/http
import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/json
import gleam/result
import wisp

pub fn create_static_pull_zone(name: String) {
  let bunny_api_url = envie.get_string("BUNNY_API_URL", "https://api.bunny.net")
  let assert Ok(bunny_api_key) = envie.get("BUNNY_API_KEY")
    as "BUNNY_API_KEY is required"
  let assert Ok(bunny_storage_zone_id) = envie.get("BUNNY_STORAGE_ZONE_ID")
    as "BUNNY_STORAGE_ZONE_ID is required"
  let assert Ok(bunny_storage_zone_id) = bunny_storage_zone_id |> int.parse
    as "BUNNY_STORAGE_ZONE_ID is not an integer"

  let suffix = case utils.is_dev() {
    True -> "-giolt-dev-"
    False -> "-giolt-"
  }

  let body =
    json.to_string(
      json.object([
        #("Name", json.string(name <> suffix <> wisp.random_string(5))),
        #("OriginUrl", json.null()),
        #("OriginType", json.int(2)),
        #("Type", json.int(1)),
        #("EnableAutoSSL", json.bool(True)),
        #("StorageZoneId", json.int(bunny_storage_zone_id)),
      ]),
    )

  let assert Ok(req) = request.to(bunny_api_url <> "/pullzone")
  let req =
    req
    |> request.set_method(http.Post)
    |> request.set_header("content-type", "application/json")
    |> request.set_header("accesskey", bunny_api_key)
    |> request.set_body(body)

  use res <- result.try(
    httpc.send(req) |> result.replace_error("Failed to send request to API"),
  )

  let parsed_id =
    json.parse(res.body, {
      use id <- decode.field("Id", decode.int)

      decode.success(id)
    })
    |> result.replace_error("Failed to decode")

  case res.status {
    201 -> parsed_id
    _ -> Error("Failed to create pull zone")
  }
}

pub fn delete_static_pull_zone(id: Int) {
  let bunny_api_url = envie.get_string("BUNNY_API_URL", "https://api.bunny.net")
  let assert Ok(bunny_api_key) = envie.get("BUNNY_API_KEY")
    as "BUNNY_API_KEY is required"

  let assert Ok(req) =
    request.to(bunny_api_url <> "/pullzone/" <> int.to_string(id))
  let req =
    req
    |> request.set_method(http.Delete)
    |> request.set_header("accesskey", bunny_api_key)

  use res <- result.try(
    httpc.send(req) |> result.replace_error("Failed to send request to API"),
  )

  case res.status {
    204 -> Ok(Nil)
    _ -> Error("Failed to create pull zone")
  }
}
