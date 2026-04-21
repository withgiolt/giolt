import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/javascript/promise.{type Promise}
import glen

pub type BetterAuth

@external(javascript, "./external/auth.ts", "get_auth")
pub fn get_auth() -> BetterAuth

@external(javascript, "./external/auth.ts", "handle_requests")
pub fn handle_requests(auth: BetterAuth, request: Request(glen.RequestBody)) -> Promise(Response(glen.ResponseBody))

@external(javascript, "./external/auth.ts", "generate_openapi_schema")
pub fn generate_openapi_schema(auth: BetterAuth) -> Promise(String)