import api/lib/auth
import api/lib/db
import api/lib/utils
import gleam/http
import gleam/javascript/promise.{type Promise}
import gleam/json
import gleam/result
import glen
import glen/status

pub fn handle_request(req: glen.Request) -> Promise(glen.Response) {
	case req.method {
		http.Get -> get(req)
		_ -> promise.resolve(glen.text("Method not allowed", 405))
	}
}

fn get(req: glen.Request) -> Promise(glen.Response) {
	let res = {
		use token <- promise.try_await(promise.resolve(
			auth.get_session_token(req)
			|> result.replace_error(#("user_data_not_loaded", status.unauthorized)),
		))
		use session <- promise.try_await(
			auth.validate_session(token)
			|> utils.promise_error(#("user_data_not_loaded", status.unauthorized)),
		)

		let db_res =
			db.get_db()
			|> db.execute(
				"SELECT * FROM users WHERE users.id = '"
				<> session.claims.subject
				<> "';",
			)

		use db_res <- promise.try_await(
			db_res
			|> utils.promise_error(#(
				"user_data_not_loaded",
				status.internal_server_error,
			)),
		)
		let db_res =
			db_res
			|> db.as_user

		case db_res {
			[user, ..] -> promise.resolve(Ok(user))
			[] -> promise.resolve(Error(#("user_data_not_onboarded", status.ok)))
		}
	}

	use res <- promise.await(res)
	case res {
		Ok(user) -> {
			promise.resolve(glen.json(
				json.object([
					#("type", json.string("user_data")),
					#("cli_token", json.string(user.cli_token)),
				])
					|> json.to_string,
				200,
			))
		}
		Error(e) -> {
			promise.resolve(glen.json(
				json.object([#("type", json.string(e.0))])
					|> json.to_string,
				e.1,
			))
		}
	}
}
