import app/lib/makeshift
import gleam/http
import wisp

pub fn handler(ctx: makeshift.RouteContext) {
  case ctx.request.method {
    http.Post -> post(ctx)
    _ -> Ok(wisp.method_not_allowed([http.Post]))
  }
}

fn post(ctx: makeshift.RouteContext) {
  todo
}
