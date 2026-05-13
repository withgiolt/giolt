import envie
import gleam/http
import gleam/http/request
import gleam/json

pub fn create_static_pull_zone(name: String) {
  let assert Ok(bunny_api_key) = envie.get("BUNNY_API_KEY")
    as "BUNNY_API_KEY is required"
  let assert Ok(bunny_api_key) = bunny_api_key |> envie.require_string
    as "BUNNY_API_KEY is not a string"
  let assert Ok(bunny_storage_zone_id) = envie.get("BUNNY_STORAGE_ZONE_ID")
    as "BUNNY_STORAGE_ZONE_ID is required"
  let assert Ok(bunny_storage_zone_id) =
    bunny_storage_zone_id |> envie.require_int
    as "BUNNY_STORAGE_ZONE_ID is not an integer"

  let body =
    json.to_string(
      json.object([
        #("Name", json.string(name)),
        #("OriginUrl", json.null()),
        #("OriginType", json.int(2)),
        #("Type", json.int(1)),
        #("EnableAutoSSL", json.bool(True)),
        #("StorageZoneId", json.int(bunny_storage_zone_id)),
      ]),
    )

  let assert Ok(req) = request.to("https://api.bunny.net/pullzone")
  let req =
    req
    |> request.set_method(http.Post)
    |> request.set_header("content-type", "application/json")
    |> request.set_header("accesskey", bunny_api_key)
    |> request.set_body(body)
}
