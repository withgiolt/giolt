import app/layouts/dashboard_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
  let el =
    dashboard_layout.view(ctx, [], [
      h.div([a.class("container space-y-2")], [
        h.h2([a.class("text-5xl font-bold")], [h.text("New project")]),
        h.form([a.class("")], [
          h.input([a.class("input")]),
          h.button([a.type_("submit"), a.class("btn")], []),
        ]),
      ]),
    ])

  makeshift.return(el, ctx)
}
