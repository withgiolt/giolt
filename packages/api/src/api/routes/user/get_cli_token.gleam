import gleam/json
import api/lib/auth
import gleam/javascript/promise.{type Promise}
import glen
import api/lib/db

pub fn handle_request(req: glen.Request) -> Promise(glen.Response) {
	let res = {
		use token <- promise.try_await(promise.resolve(auth.get_session_token(req)))
		use session <- promise.try_await(auth.validate_session(token))

		let db_res = db.get_db()
		|> db.execute("SELECT cli_token FROM users WHERE users.id = '" <> session.claims.subject <> "';")

		use db_res <- promise.try_await(db_res)
		let db_res = db_res
		|> db.as_user

		case db_res {
			[user, ..] -> promise.resolve(Ok(user))
			[] -> promise.resolve(Error("User does not exist"))
		}
	}

	use res <- promise.await(res)
	case res {
		Ok(user) -> {
			promise.resolve(glen.json(json.object([
				#("cli_token", json.string(user.cli_token))
			]) |> json.to_string, 200))
		}
		Error(e) -> {
			promise.resolve(glen.json(json.object([
				#("error", json.string(e))
			]) |> json.to_string, 500))
		}
	}
}
