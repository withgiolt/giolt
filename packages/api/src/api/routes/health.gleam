import gleam/javascript/promise.{type Promise}
import glen
import glen/status

pub fn handle_request(_req: glen.Request) -> Promise(glen.Response) {
	"Up and running!"
	|> glen.text(status.ok)
	|> promise.resolve
}
