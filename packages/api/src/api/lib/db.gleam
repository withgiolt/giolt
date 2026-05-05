import gleam/dynamic
import gleam/dynamic/decode
import gleam/javascript/promise.{type Promise}
import gleam/list

pub type DatabaseClient

pub type SQLStatement =
	String

pub type Project {
	Project(
		id: String,
		slug: String,
		pull_zone_id: String,
		owner_id: String,
		type_: ProjectType,
		server_id: String,
	)
}

pub type ProjectType {
	Static
	Service
}

fn project_decoder() -> decode.Decoder(Project) {
	use id <- decode.optional_field("id", "0", decode.string)
	use slug <- decode.optional_field("slug", "0", decode.string)
	use pull_zone_id <- decode.optional_field("pull_zone_id", "0", decode.string)
	use owner_id <- decode.optional_field("owner_id", "0", decode.string)
	use type_ <- decode.optional_field("type", Static, {
		use variant <- decode.then(decode.string)
		case variant {
			"static" -> decode.success(Static)
			"service" -> decode.success(Service)
			_ -> decode.failure(Static, "ProjectType")
		}
	})
	use server_id <- decode.optional_field("server_id", "0", decode.string)
	decode.success(Project(
		id:,
		slug:,
		pull_zone_id:,
		owner_id:,
		type_:,
		server_id:,
	))
}

pub type Server {
	Server(id: Int, region: String, capacity: Int)
}

fn server_decoder() -> decode.Decoder(Server) {
	use id <- decode.optional_field("id", 0, decode.int)
	use region <- decode.optional_field("region", "0", decode.string)
	use capacity <- decode.optional_field("capacity", 0, decode.int)
	decode.success(Server(id:, region:, capacity:))
}

pub type User {
	User(
		id: String, 
		billing_status: UserBillingStatus, 
		billing_date: Int,
		cli_token: String
	)
}

pub type UserBillingStatus {
	Active
	Inactive
}

fn user_decoder() -> decode.Decoder(User) {
	use id <- decode.optional_field("id", "0", decode.string)
	use billing_status <- decode.optional_field("billing_status", Inactive, {
		use variant <- decode.then(decode.string)
		case variant {
			"active" -> decode.success(Active)
			"inactive" -> decode.success(Inactive)
			_ -> decode.failure(Active, "UserBillingStatus")
		}
	})
	use cli_token <- decode.optional_field("cli_token", "0", decode.string)
	use billing_date <- decode.optional_field("billing_date", 0, decode.int)
	decode.success(User(id:, billing_status:, billing_date:, cli_token:))
}

@external(javascript, "./db.ffi.ts", "get_db")
pub fn get_db() -> DatabaseClient

@external(javascript, "./db.ffi.ts", "execute")
pub fn execute(
	db: DatabaseClient,
	statement: String,
) -> Promise(Result(List(dynamic.Dynamic), String))

pub fn as_project(rows: List(dynamic.Dynamic)) -> List(Project) {
	list.map(rows, fn(item) {
		let decode_result = decode.run(item, project_decoder())

		case decode_result {
			Ok(res) -> res
			Error(_) -> panic as "Wrong type returned"
		}
	})
}

pub fn as_server(rows: List(dynamic.Dynamic)) -> List(Server) {
	list.map(rows, fn(item) {
		let decode_result = decode.run(item, server_decoder())

		case decode_result {
			Ok(res) -> res
			Error(_) -> panic as "Wrong type returned"
		}
	})
}

pub fn as_user(rows: List(dynamic.Dynamic)) -> List(User) {
	list.map(rows, fn(item) {
		let decode_result = decode.run(item, user_decoder())

		case decode_result {
			Ok(res) -> res
			Error(_) -> panic as "Wrong type returned"
		}
	})
}
