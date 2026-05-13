import app/layouts/dashboard_layout
import app/lib/db
import app/lib/makeshift
import gleam/http
import lustre/attribute as a
import lustre/element/html as h
import wisp

pub fn view(ctx: makeshift.RouteContext) {
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
            h.input([
              a.class("input"),
              a.name("name"),
              a.placeholder("Project name"),
              a.required(True),
              a.type_("text"),
            ]),
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
    [#("name", name)] -> {
      let res =
        db.execute(
          "INSERT INTO projects (slug, pull_zone_id, owner_id, type, server_id) VALUES ('"
          <> name
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

      case res {
        Ok(_) -> wisp.redirect("/")
        Error(e) -> {
          makeshift.redirect_error(e, "/project/new")
        }
      }
    }
    _ -> makeshift.redirect_error("Need to provide name", "/project/new")
  }
}
