import gleam/javascript/promise.{type Promise}
import gleam/result

pub fn promise_error(prom: Promise(Result(a, b)), error_string: String) {
	use prom <- promise.map(prom)
	result.replace_error(prom, error_string)
}
