import gleam/javascript/promise.{type Promise}
import gleam/result

pub fn promise_error(
	prom: Promise(Result(a, b)),
	error: f,
) -> Promise(Result(a, f)) {
	use prom <- promise.map(prom)
	result.replace_error(prom, error)
}
