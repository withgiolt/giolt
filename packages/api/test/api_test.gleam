import api/lib/db.{type DatabaseClient}
import gleam/javascript/promise.{type Promise}
import gleam/list
import gleeunit
import gleeunit/should

pub fn main() -> Nil {
	gleeunit.main()
}

@external(javascript, "./api/lib/db.ffi.ts", "get_db_test")
fn get_db() -> Promise(DatabaseClient)

// gleeunit test functions end in `_test`
pub fn db_read_test() {
	use client <- promise.await(get_db())
	use res <- promise.await(db.execute(client, "SELECT * FROM projects"))

	should.be_ok(res)
	let assert Ok(res) = res
	assert res == []

	promise.resolve(Nil)
}

pub fn db_fail_test() {
	use client <- promise.await(get_db())
	use res <- promise.await(db.execute(client, "SELECT * FROM projests"))

	should.be_error(res)

	promise.resolve(Nil)
}

pub fn db_write_test() {
	use client <- promise.await(get_db())
	use res <- promise.await(db.execute(
		client,
		"INSERT INTO servers (region, capacity) VALUES ('bucharest', 50);",
	))

	should.be_ok(res)

	use res <- promise.await(db.execute(client, "SELECT * FROM servers"))

	should.be_ok(res)
	let assert Ok(res) = res
	assert list.length(res) == 1
	let res = db.as_server(res)

	let assert Ok(entry) = list.first(res)
	should.equal(entry.region, "bucharest")

	promise.resolve(Nil)
}
