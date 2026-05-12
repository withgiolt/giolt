import app/lib/auth
import app/lib/db
import app/lib/makeshift
import app/lib/renderer
import app/routes/api/rotate_cli_token
import gleam/dict
import gleam/option
import gleam/string
import lustre/element
import wisp

import app/routes/account
import app/routes/cli
import app/routes/index
import app/routes/login
import app/routes/not_found
import app/routes/project/new as project_new
import app/routes/project/project
import app/routes/setting_up

pub fn handler(req: wisp.Request) {
  let assert Ok(priv) = wisp.priv_directory("app")
  use <- wisp.serve_static(req, "/", priv)

  let api_route = api_route_handler(req)
  case api_route {
    Ok(api_route) -> {
      case api_route {
        Ok(api_route) -> api_route
        Error(_) -> wisp.html_response("<h1>Very bad man</h1>", 500)
      }
    }
    // Fallback to pages
    Error(_) -> {
      let route = route_handler(req)

      case route {
        Ok(route) -> route.res |> wisp.html_body(renderer.render(route.el))
        Error(e) ->
          wisp.html_response(
            "<h1>Very bad man" <> string.inspect(e) <> " </h1>",
            500,
          )
      }
    }
  }
}

fn api_route_handler(req: wisp.Request) {
  let session = auth.get_session(req)

  let route = case wisp.path_segments(req) {
    ["api", "rotate-cli-token"] -> option.Some(rotate_cli_token.handler)
    _ -> option.None
  }

  case route {
    option.Some(handler) -> {
      let context =
        makeshift.RouteContext(
          overriden: False,
          params: dict.from_list(wisp.get_query(req)),
          session: case session {
            Ok(session) -> session
            Error(_) -> auth.Unauthenticated
          },
          request: req,
          response: wisp.ok()
            |> wisp.set_header("content-type", "text/html"),
        )

      Ok(handler(context))
    }
    option.None -> Error("No API Route")
  }
}

fn route_handler(req: wisp.Request) {
  let session = auth.get_session(req)

  let route: fn(makeshift.RouteContext) ->
    Result(makeshift.RouteResponse, makeshift.RouteError) = case
    wisp.path_segments(req)
  {
    [] -> index.view
    ["project", "new"] -> project_new.view
    ["project", _] -> project.view
    ["cli"] -> cli.view
    ["account"] -> account.view
    ["login"] -> login.view
    ["setting-up"] -> setting_up.view
    _ -> not_found.view
  }
  let context =
    makeshift.RouteContext(
      overriden: False,
      params: dict.from_list(wisp.get_query(req)),
      session: case session {
        Ok(session) -> session
        Error(_) -> auth.Unauthenticated
      },
      request: req,
      response: wisp.ok()
        |> wisp.set_header("content-type", "text/html"),
    )
    |> route_guard

  case context.overriden {
    True ->
      Ok(makeshift.RouteResponse(el: element.none(), res: context.response))
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
