import app/layouts/base_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
  let el =
    base_layout.view(ctx, [], [
      h.div(
        [
          a.class(
            "container text-center h-svh flex flex-col justify-center items-center",
          ),
        ],
        [
          h.h1([a.class("text-5xl font-bold")], [h.text("Oops...")]),
          h.p([], [h.text("Maybe wrong URL?")]),
          h.p([], [
            h.text("Unfortunately this page doesn't exist."),
          ]),
          h.a([a.href("/"), a.class("btn btn-primary")], [h.text("Go back")]),
        ],
      ),
    ])

  makeshift.return(el, ctx)
}
