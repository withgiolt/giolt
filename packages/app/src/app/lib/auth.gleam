import gleam/httpc
import app/lib/makeshift
import gleam/list
import envie
import gleam/dynamic/decode
import gleam/http
import gleam/http/request
import gleam/json
import gleam/result

pub type SessionStatus {
	SessionStatus(is_valid: Bool, claims: SessionStatusClaims)
}

pub type SessionStatusClaims {
	SessionStatusClaims(subject: String)
}

fn session_status_decoder() -> decode.Decoder(SessionStatus) {
	use is_valid <- decode.field("is_valid", decode.bool)
	use claims <- decode.field("claims", {
		use subject <- decode.field("subject", decode.string)
		decode.success(SessionStatusClaims(subject:))
	})
	decode.success(SessionStatus(is_valid:, claims:))
}

pub fn get_session_token(ctx: makeshift.RouteContext) -> Result(String, String) {
	let cookies = request.get_cookies(ctx.request)
	
	list.key_find(cookies, "hanko") |> result.replace_error("User does not have auth cookie")
}

pub fn validate_session(
	session_token: String,
) -> Result(SessionStatus, String) {
	let api_url = envie.get_string("AUTH_URL", "")

	let req_body =
		json.object([
			#("session_token", json.string(session_token)),
		])

	let assert Ok(req) = request.to(api_url <> "/sessions/validate") as "AUTH_URL may not be valid"

	let req =
		req
		|> request.set_method(http.Post)
		|> request.set_header("Content-Type", "application/json")
		|> request.set_body(json.to_string(req_body))

	use res <- result.try(httpc.send(req) |> result.replace_error("Failed to fetch from auth API"))

	json.parse(res.body, session_status_decoder()) |> result.replace_error("Failed to decode")
}
