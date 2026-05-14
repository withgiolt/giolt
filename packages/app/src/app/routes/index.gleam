import app/layouts/dashboard_layout
import app/lib/db
import app/lib/makeshift
import gleam/list
import gleam/result
import lucide_lustre
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
  use user_id <- makeshift.require_auth_result(ctx)
  use projects <- result.try(
    db.execute("SELECT * FROM projects WHERE owner_id = '" <> user_id <> "';")
    |> makeshift.replace_error(makeshift.RouteErrorServer),
  )
  let projects =
    projects
    |> db.as_project

  let el =
    dashboard_layout.view(ctx, [a.class("container m-2")], case projects {
      [] -> [no_projects([], [])]
      _ -> [
        h.div(
          [
            a.class(
              "grid grid-row gap-2 grid-cols-1 md:grid-cols-3 lg:grid-cols-4",
            ),
          ],
          list.map(projects, fn(project) {
            h.a([a.class("card glass"), a.href("/project/" <> project.slug)], [
              h.div([a.class("card-body")], [
                h.h3([a.class("card-title")], [h.text(project.slug)]),
              ]),
            ])
          }),
        ),
      ]
    })

  makeshift.return(el, ctx)
}

fn no_projects(_, _) {
  h.div(
    [a.class("flex flex-col justify-center items-center text-center gap-2")],
    [
      lucide_lustre.binoculars([a.class("size-32 mb-4")]),
      h.h2([a.class("text-5xl font-bold")], [h.text("No projects")]),
      h.p([], [h.text("You have no projects")]),
      h.a([a.class("btn btn-primary"), a.href("/project/new")], [
        lucide_lustre.plus([]),
        h.text("Create project"),
      ]),
    ],
  )
}
