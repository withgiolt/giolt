import gleam/result
import gleam/httpc
import gleam/http
import gleam/http/request
import gleam/json

pub type BunnyClient{
	BunnyClient(
		access_key: String
	)
}

pub type Zone {}

const api_url = "https://api.bunny.net"

pub fn create_bunny_client(access_key: String) -> BunnyClient {
	BunnyClient(access_key)
}

// pub fn create_pull_zone(client: BunnyClient, zone_name: String, max_bandwidth_gb: Int) -> Result(Zone, String) {
	
// 	let request_data = json.object([
// 		#("Name", json.string(zone_name)),
// 		#("MonthlyBandwidthLimit", json.int(max_bandwidth_gb * 1024 * 1024 * 1024))
// 	])

// 	let assert Ok(req) = request.to(api_url <> "/pullzone")

// 	req
// 	|> request.set_method(http.Post)
// 	|> request.set_body(json.to_string(request_data))

// }