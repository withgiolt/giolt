import app/layouts/dashboard_layout
import app/lib/cdn
import app/lib/db
import app/lib/makeshift
import gleam/http
import gleam/list
import gleam/result
import lustre/attribute as a
import lustre/element/html as h
import wisp

pub fn view(ctx: makeshift.RouteContext) {
  let assert Ok(project_id) = case wisp.path_segments(ctx.request) {
    [_, project_id] -> Ok(project_id)
    _ -> Error(Nil)
  }

  let el =
    dashboard_layout.view(ctx, [], [
      h.p([], [
        h.text("This is project id: " <> project_id),
      ]),
      h.form([a.method("post")], [
        h.input([a.type_("hidden"), a.name("operation"), a.value("delete")]),
        h.button([a.type_("submit"), a.class("btn btn-primary")], [
          h.text("Delete"),
        ]),
      ]),
    ])

  makeshift.return(el, ctx)
}

pub fn post(ctx: makeshift.RouteContext) {
  use <- wisp.require_method(ctx.request, http.Post)
  use form <- wisp.require_form(ctx.request)
  let assert Ok(project_slug) = list.key_find(ctx.metadata, "slug")

  let res = case form.values {
    [#("operation", operation), ..] ->
      case operation {
        "delete" -> {
          use projects <- result.try(db.execute(
            "SELECT * FROM projects WHERE slug = '"
            <> project_slug
            <> "' LIMIT 1;",
          ))
          let projects =
            projects
            |> db.as_project

          case projects {
            [project] -> {
              use _ <- result.try(cdn.delete_static_pull_zone(
                project.pull_zone_id,
              ))
              use _ <- result.try(db.execute(
                "DELETE FROM projects WHERE slug = '" <> project_slug <> "';",
              ))

              Ok(Nil)
            }
            _ -> Error("Database returned no projects")
          }
        }
        _ -> Error("Invalid operation")
      }
    _ -> Error("Invalid operation")
  }

  case res {
    Ok(_) -> wisp.redirect("/")
    Error(e) -> makeshift.redirect_error(e, "/project/" <> project_slug)
  }
}
