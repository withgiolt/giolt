import gleam/http
import gleam/http/request
import gleam/dynamic/decode
import rsvp
import app/lib/env
import lustre/effect

pub type CliTokenResponse {
	CliTokenResponse(
		cli_token: String
	)
}

fn cli_token_response_decoder() -> decode.Decoder(String) {
  use cli_token <- decode.field("cli_token", decode.string)
  decode.success(cli_token)
}

pub fn get_cli_token(
	on_response handle_response: fn(Result(String, rsvp.Error(String))) -> message,
	token token: String
) -> effect.Effect(message) {
	let api_url = env.get_or("API_URL", "http://localhost:3000")
	let assert Ok(req) = request.to(api_url <> "/api/user/get-cli-token")
	let req = req
	|> request.set_method(http.Get)
	|> request.set_header("authorization", "Bearer " <> token)
	
	let handler = rsvp.expect_json(cli_token_response_decoder(), handle_response)

	rsvp.send(req, handler)
}