import gleam/http
import api/lib/utils
import gleam/result
import gleam/json
import api/lib/auth
import gleam/javascript/promise.{type Promise}
import glen
import api/lib/db

pub fn handle_request(req: glen.Request) -> Promise(glen.Response) {
	case req.method {
		http.Get -> get(req)
		_ -> promise.resolve(glen.text("Method not allowed", 405))
	}
}

fn get(req: glen.Request) -> Promise(glen.Response) {
	let res = {
		use token <- promise.try_await(promise.resolve(auth.get_session_token(req) |> result.replace_error(#("Couldn't get session token", 401))))
		use session <- promise.try_await(auth.validate_session(token) |> utils.promise_error(#("Couldn't validate session", 401)))

		let db_res = db.get_db()
		|> db.execute("SELECT * FROM users WHERE users.id = '" <> session.claims.subject <> "';")

		use db_res <- promise.try_await(db_res |> utils.promise_error(#("Couldn't fetch database", 500)))
		let db_res = db_res
		|> db.as_user

		case db_res {
			[user, ..] -> promise.resolve(Ok(user))
			[] -> promise.resolve(Error(#("User does not exist", 404)))
		}
	}

	use res <- promise.await(res)
	case res {
		Ok(user) -> {
			promise.resolve(glen.json(json.object([
				#("type", json.string("user_data")),
				#("cli_token", json.string(user.cli_token))
			]) |> json.to_string, 200))
		}
		Error(e) -> {
			promise.resolve(glen.json(json.object([
				#("error", json.string(e.0))
			]) |> json.to_string, e.1))
		}
	}
}