import app/lib/auth
import app/lib/renderer
import gleam/dict
import gleam/http/response
import gleam/option
import gleam/result
import gleam/uri
import lustre/attribute
import lustre/element
import wisp

pub type RouteError {
  RouteErrorServer
  RouteErrorUnauthorized
  RouteErrorBadRequest
}

pub type Element =
  element.Element(Nil)

pub type Attribute =
  attribute.Attribute(Nil)

pub type Attributes =
  List(Attribute)

pub type Children =
  List(Element)

pub type RouteResponse {
  RouteResponse(el: option.Option(Element), res: wisp.Response)
}

pub type RouteContext {
  RouteContext(
    request: wisp.Request,
    response: wisp.Response,
    session: auth.Session,
    params: dict.Dict(String, String),
    overriden: Bool,
    metadata: dict.Dict(String, String),
  )
}

pub fn replace_error(res: Result(a, b), error: RouteError) {
  res
  |> result.replace_error(error)
}

pub fn route_error_to_code(error: RouteError) {
  case error {
    RouteErrorServer -> 500
    RouteErrorBadRequest -> 400
    RouteErrorUnauthorized -> 401
  }
}

pub fn return(el: Element, ctx: RouteContext) {
  Ok(RouteResponse(option.Some(el), ctx.response))
}

pub fn raw_wrapper(res: fn(RouteContext) -> wisp.Response) {
  fn(ctx) { Ok(RouteResponse(el: option.None, res: res(ctx))) }
}

pub fn require_auth_result(
  ctx: RouteContext,
  next: fn(String) -> Result(a, RouteError),
) {
  case ctx.session {
    auth.Authenticated(id) -> next(id)
    auth.Unauthenticated -> Error(RouteErrorUnauthorized)
  }
}

pub fn require_auth(ctx: RouteContext, next: fn(String) -> wisp.Response) {
  case ctx.session {
    auth.Authenticated(id) -> next(id)
    auth.Unauthenticated -> wisp.html_response("Unauthorized", 401)
  }
}

pub fn redirect_error(reason: String, path: String) -> wisp.Response {
  let params = uri.query_to_string([#("reason", reason), #("return", path)])

  wisp.redirect("/error?" <> params)
}

pub fn route_to_response(
  ctx: RouteContext,
  route: fn(RouteContext) -> Result(RouteResponse, RouteError),
) {
  case route(ctx) {
    Ok(res) ->
      case res.el {
        option.Some(el) -> res.res |> wisp.html_body(renderer.render(el))
        option.None -> res.res
      }
    Error(_) -> redirect_error("Unknown error", ctx.request.path)
  }
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

pub fn set_metadata(ctx: RouteContext, key: String, value: String) {
  let metadata = dict.insert(ctx.metadata, key, value)
  RouteContext(..ctx, metadata:)
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
  RouteContext(
    ..ctx
    |> set_status(307)
    |> set_header("location", url),
    overriden: True,
  )
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
