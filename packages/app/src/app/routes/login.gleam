import app/components/auth/login
import app/components/dynamic_logo
import app/layouts/base_layout
import app/lib/makeshift
import lustre/attribute as a
import lustre/element/html as h

pub fn view(ctx: makeshift.RouteContext) {
  let el =
    base_layout.view(
      ctx,
      [
        a.class("flex flex-row h-svh"),
      ],
      [
        h.div([], [
          h.img([
            a.class(
              "hidden dark:inline object-cover object-right w-full h-full",
            ),
            a.src("/layered-steps-dark.svg"),
            a.loading("eager"),
          ]),
          h.img([
            a.class(
              "inline dark:hidden object-cover object-right w-full h-full",
            ),
            a.src("/layered-steps-light.svg"),
            a.loading("eager"),
          ]),
        ]),
        h.div(
          [
            a.class("flex flex-col justify-center items-center md:min-w-96"),
          ],
          [
            login.view([a.class("w-full")]),
            dynamic_logo.view([a.class("size-8")]),
          ],
        ),
      ],
    )

  makeshift.return(el, ctx)
}
