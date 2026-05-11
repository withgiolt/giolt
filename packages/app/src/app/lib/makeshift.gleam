import app/lib/auth
import gleam/http/response
import lustre/attribute
import lustre/element
import wisp

pub type Element =
	element.Element(Nil)

pub type Attribute =
	attribute.Attribute(Nil)

pub type Attributes =
	List(Attribute)

pub type Children =
	List(Element)

pub type RouteResponse {
	RouteResponse(el: Element, res: wisp.Response)
}

pub type RouteContext {
	RouteContext(
		request: wisp.Request,
		response: wisp.Response,
		session: auth.Session,
	)
}

pub fn return(el: Element, ctx: RouteContext) {
	Ok(RouteResponse(el, ctx.response))
}

pub fn set_status(ctx: RouteContext, status: Int) {
	let new_res =
		response.new(status)
		|> response.set_body(ctx.response.body)
		|> bulk_set_header(ctx.response.headers)

	RouteContext(..ctx, response: new_res)
}

pub fn set_header(ctx: RouteContext, key: String, value: String) {
	let new_res = wisp.set_header(ctx.response, key, value)
	RouteContext(..ctx, response: new_res)
}

pub fn set_cookie(ctx: RouteContext, name: String, value: String) {
	let new_res =
		wisp.set_cookie(
			request: ctx.request,
			response: ctx.response,
			security: wisp.Signed,
			name:,
			value:,
			max_age: 60 * 60,
		)

	RouteContext(..ctx, response: new_res)
}

pub fn redirect_to(ctx: RouteContext, url: String) {
	ctx
	|> set_status(307)
	|> set_header("location", url)
}

fn bulk_set_header(
	res: wisp.Response,
	headers: List(#(String, String)),
) -> wisp.Response {
	case headers {
		[] -> res
		[#(key, value), ..rest] ->
			bulk_set_header(response.set_header(res, key, value), rest)
	}
}
