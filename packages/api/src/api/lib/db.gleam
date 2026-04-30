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
	use id <- decode.field("id", decode.string)
	use slug <- decode.field("slug", decode.string)
	use pull_zone_id <- decode.field("pull_zone_id", decode.string)
	use owner_id <- decode.field("owner_id", decode.string)
	use type_ <- decode.field("type", {
		use variant <- decode.then(decode.string)
		case variant {
			"static" -> decode.success(Static)
			"service" -> decode.success(Service)
			_ -> decode.failure(Static, "ProjectType")
		}
	})
	use server_id <- decode.field("server_id", decode.string)
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
	use id <- decode.field("id", decode.int)
	use region <- decode.field("region", decode.string)
	use capacity <- decode.field("capacity", decode.int)
	decode.success(Server(id:, region:, capacity:))
}

pub type User {
	User(id: String, billing_status: UserBillingStatus, billing_date: Int)
}

pub type UserBillingStatus {
	Active
	Inactive
}

fn user_decoder() -> decode.Decoder(User) {
	use id <- decode.field("id", decode.string)
	use billing_status <- decode.field("billing_status", {
		use variant <- decode.then(decode.string)
		case variant {
			"active" -> decode.success(Active)
			"inactive" -> decode.success(Inactive)
			_ -> decode.failure(Active, "UserBillingStatus")
		}
	})
	use billing_date <- decode.field("billing_date", decode.int)
	decode.success(User(id:, billing_status:, billing_date:))
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
