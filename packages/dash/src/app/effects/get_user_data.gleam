import app/lib/auth
import gleam/http
import gleam/http/request
import rsvp
import app/lib/env
import lustre/effect

pub fn get_user_data(
	on_response handle_response: fn(Result(auth.UserData, rsvp.Error(String))) -> message,
	token token: String
) -> effect.Effect(message) {
	let api_url = env.get_or("API_URL", "http://localhost:3000")
	let assert Ok(req) = request.to(api_url <> "/api/user")
	let req = req
	|> request.set_method(http.Get)
	|> request.set_header("authorization", "Bearer " <> token)
	
	let handler = rsvp.expect_json(auth.user_data_decoder(), handle_response)

	rsvp.send(req, handler)
}