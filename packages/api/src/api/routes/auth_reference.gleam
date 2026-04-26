import gleam/javascript/promise.{type Promise}
import glen
import glen/status
import api/lib/auth

pub fn handle_request(_req: glen.Request) -> Promise(glen.Response) {
	use reference <- promise.await(auth.generate_openapi_schema(auth.get_auth()))

	glen.text(reference, status.ok)
	|> promise.resolve
}
