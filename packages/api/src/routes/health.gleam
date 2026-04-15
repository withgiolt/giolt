import wisp.{type Request, type Response}

pub fn handle_request(_req: Request) -> Response {
	wisp.ok()
	|> wisp.string_body("Up and running!")
}