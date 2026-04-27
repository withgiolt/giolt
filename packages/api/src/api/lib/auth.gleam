import api/lib/utils
import envie
import gleam/dynamic/decode
import gleam/fetch
import gleam/http
import gleam/http/request
import gleam/javascript/promise.{type Promise}
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

pub fn validate_session(
	session_token: String,
) -> Promise(Result(SessionStatus, String)) {
	let api_url = envie.get_string("API_URL", "")

	let req_body =
		json.object([
			#("session_token", json.string(session_token)),
		])

	let assert Ok(req) = request.to(api_url <> "/sessions/validate")

	let req =
		req
		|> request.set_method(http.Post)
		|> request.set_header("Content-Type", "application/json")
		|> request.set_body(json.to_string(req_body))

	use res <- promise.try_await(
		fetch.send(req) |> utils.promise_error("Failed to fetch"),
	)
	use res <- promise.try_await(
		fetch.read_json_body(res) |> utils.promise_error("Failed to read JSON body"),
	)
	let session_status =
		decode.run(res.body, session_status_decoder())
		|> result.replace_error("Failed to decode")

	promise.resolve(session_status)
}
