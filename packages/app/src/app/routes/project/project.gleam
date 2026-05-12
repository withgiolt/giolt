import app/layouts/dashboard_layout
import app/lib/makeshift
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
      h.button([a.class("btn btn-primary")], [h.text("Hello world!")]),
    ])

  makeshift.return(el, ctx)
}
