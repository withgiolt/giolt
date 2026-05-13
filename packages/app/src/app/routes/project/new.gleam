import app/layouts/dashboard_layout
import app/lib/db
import app/lib/makeshift
import gleam/dict
import gleam/http
import gleam/result
import gleam/string
import lustre/attribute as a
import lustre/element/html as h
import wisp

pub fn view(ctx: makeshift.RouteContext) {
  let error_reason = dict.get(ctx.metadata, "error_reason")

  let el =
    dashboard_layout.view(ctx, [], [
      h.div([a.class("container space-y-2 my-2")], [
        h.h2([a.class("text-5xl font-bold")], [h.text("New project")]),
        h.form(
          [
            a.id("form"),
            a.method("post"),
            a.class("flex flex-col gap-2 max-w-64"),
          ],
          [
            h.p([a.class("text-error")], [
              h.text(result.unwrap(error_reason, "")),
            ]),
            h.input([
              a.class("input"),
              a.name("name"),
              a.placeholder("Project name"),
              a.required(True),
              a.type_("text"),
            ]),
            h.fieldset(
              [
                a.class(
                  "fieldset bg-base-200 border-base-300 rounded-box p-4 border",
                ),
              ],
              [
                h.legend([a.class("fieldset-legend")], [h.text("Project type")]),
                h.label([a.class("label ")], [
                  h.input([
                    a.class("radio radio-primary"),
                    a.type_("radio"),
                    a.name("type"),
                    a.value("static"),
                    a.checked(True),
                  ]),
                  h.text("Static"),
                ]),
                h.label([a.class("label")], [
                  h.input([
                    a.class("radio radio-primary"),
                    a.type_("radio"),
                    a.name("type"),
                    a.value("service"),
                    a.disabled(True),
                  ]),
                  h.text("Service (Coming soon)"),
                ]),
              ],
            ),
            h.button([a.type_("submit"), a.class("btn")], [h.text("Create")]),
          ],
        ),
      ]),
    ])

  makeshift.return(el, ctx)
}

pub fn post(ctx: makeshift.RouteContext) {
  use <- wisp.require_method(ctx.request, http.Post)
  use user_id <- makeshift.require_auth(ctx)
  use form_data <- wisp.require_form(ctx.request)

  case form_data.values {
    [#("name", name), #("type", _)] -> {
      let res =
        db.execute(
          "INSERT INTO projects (slug, pull_zone_id, owner_id, type, server_id) VALUES ('"
          <> string.lowercase(name)
          <> "', '"
          <> "what"
          <> "', '"
          <> user_id
          <> "', '"
          <> "static"
          <> "', "
          <> "0"
          <> ");",
        )
        |> result.replace_error("Couldn't create new project")

      case res {
        Ok(_) -> wisp.redirect("/")
        Error(e) -> {
          makeshift.route_to_response(
            ctx
              |> makeshift.set_metadata("error_reason", e),
            view,
          )
        }
      }
    }
    _ ->
      makeshift.route_to_response(
        ctx
          |> makeshift.set_metadata(
            "error_reason",
            "Insufficient data provided",
          ),
        view,
      )
  }
}
