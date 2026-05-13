import lustre/element
import gleam/dict
import app/layouts/base_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
  let reason = dict.get(ctx.params, "reason")
  let return = dict.get(ctx.params, "return")

  case reason, return {
    Ok(reason), Ok(return) -> {
      let el =
        base_layout.view(ctx, [], [
          h.div(
            [
              a.class(
                "container text-center h-svh flex flex-col justify-center items-center ",
              ),
            ],
            [
              h.h1([a.class("text-5xl font-bold")], [h.text("Oops...")]),
              h.p([], [h.text("Something bad happened")]),
              h.p([], [h.text("\"" <> reason <> "\"")]),
              h.a([a.href(return), a.class("btn btn-primary")], [h.text("Go back")]),
            ],
          ),
        ])

      makeshift.return(el, ctx)
    }
    _, _ -> makeshift.return(element.none(), ctx |> makeshift.redirect_to("/"))
  }
}
