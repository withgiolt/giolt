import app/lib/auth
import app/lib/db
import app/lib/makeshift
import gleam/http
import gleam/result
import wisp

pub fn handler(ctx: makeshift.RouteContext) {
  case ctx.request.method {
    http.Post -> post(ctx)
    _ -> Ok(wisp.method_not_allowed([http.Post]))
  }
}

fn post(ctx: makeshift.RouteContext) {
  case ctx.session {
    auth.Authenticated(id) -> {
      use _ <- result.try(db.execute(
        "UPDATE users SET cli_token = hex(randomblob(24)) WHERE id = '"
        <> id
        <> "';",
      ))

      Ok(wisp.redirect("/cli"))
    }
    auth.Unauthenticated -> Ok(wisp.bad_request("Unauthenticated"))
  }
}
