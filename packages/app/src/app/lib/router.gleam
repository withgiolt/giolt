import app/routes/error
import app/lib/auth
import app/lib/db
import app/lib/makeshift
import app/lib/renderer
import gleam/dict
import gleam/http
import gleam/option
import gleam/string
import wisp

import app/routes/account
import app/routes/cli
import app/routes/index
import app/routes/login
import app/routes/not_found
import app/routes/project/new as project_new
import app/routes/project/project
import app/routes/setting_up

fn route_matcher(
  req: wisp.Request,
) -> fn(makeshift.RouteContext) ->
  Result(makeshift.RouteResponse, makeshift.RouteError) {
  case wisp.path_segments(req), req.method {
    [], http.Get -> index.view
    ["project", "new"], http.Get -> project_new.view
    ["project", "new"], http.Post -> makeshift.raw_wrapper(project_new.post)
    ["project", _], http.Get -> project.view
    ["cli"], http.Get -> cli.view
    ["cli"], http.Post -> makeshift.raw_wrapper(cli.post)
    ["account"], http.Get -> account.view
    ["login"], http.Get -> login.view
    ["setting-up"], http.Get -> setting_up.view
    ["error"], http.Get -> error.view
    _, _ -> not_found.view
  }
}

pub fn handler(req: wisp.Request) {
  let assert Ok(priv) = wisp.priv_directory("app")
  use <- wisp.serve_static(req, "/", priv)

  let route = route_handler(req)

  case route {
    Ok(route) ->
      case route.el {
        option.Some(el) ->
          route.res
          |> wisp.html_body(renderer.render(el))
        option.None -> route.res
      }
    Error(e) ->
      wisp.html_response(
        "<h1>Very bad man" <> string.inspect(e) <> " </h1>",
        500,
      )
  }
}

fn route_handler(req: wisp.Request) {
  let session = auth.get_session(req)

  let route = route_matcher(req)

  let context =
    makeshift.RouteContext(
      overriden: False,
      params: dict.from_list(wisp.get_query(req)),
      session: case session {
        Ok(session) -> session
        Error(_) -> auth.Unauthenticated
      },
      metadata: dict.from_list([]),
      request: req,
      response: wisp.ok()
        |> wisp.set_header("content-type", "text/html"),
    )
    |> route_guard

  case context.overriden {
    True -> Ok(makeshift.RouteResponse(el: option.None, res: context.response))
    False -> route(context)
  }
}

fn route_guard(ctx: makeshift.RouteContext) -> makeshift.RouteContext {
  case ctx.session {
    auth.Authenticated(id) ->
      case wisp.path_segments(ctx.request) {
        ["login"] -> ctx |> makeshift.redirect_to("/")
        path -> {
          let res =
            db.execute("SELECT id FROM users WHERE users.id == '" <> id <> "';")

          case res {
            Ok(res) ->
              case res, path {
                // No user and on setting up page
                [], ["setting-up"] -> ctx
                // Has user and on setting up page
                [_, ..], ["setting-up"] -> ctx |> makeshift.redirect_to("/")
                // No user and is anywhere
                [], _ -> ctx |> makeshift.redirect_to("/setting-up")
                // Has user and is anywhere
                [_, ..], _ -> ctx
              }
            Error(e) if path != ["error"] -> {
              echo e
              ctx |> makeshift.redirect_to("/error")
            }
            Error(_) -> ctx
          }
        }
      }
    auth.Unauthenticated ->
      case wisp.path_segments(ctx.request) {
        ["login"] -> ctx
        _ -> ctx |> makeshift.redirect_to("/login")
      }
  }
}