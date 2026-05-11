import app/components/nav
import app/layouts/base_layout
import app/lib/makeshift
import gleam/list
import lucide_lustre
import lustre/attribute as a
import lustre/element/html as h

pub fn view(
  ctx: makeshift.RouteContext,
  attributes: makeshift.Attributes,
  children: makeshift.Children,
) -> makeshift.Element {
  let menu_items = [
    #(lucide_lustre.grid_2x2, "Projects", "/"),
    #(lucide_lustre.square_terminal, "CLI", "/cli"),
    #(lucide_lustre.circle_user, "Account", "/account"),
  ]

  base_layout.view(Nil, [], [
    h.div([a.class("drawer lg:drawer-open")], [
      h.input([
        a.id("main-drawer"),
        a.type_("checkbox"),
        a.class("drawer-toggle"),
      ]),
      h.div([a.class("drawer-content")], [
        nav.view([], []),
        h.div(attributes, children),
      ]),

      h.div([a.class("drawer-side")], [
        h.label(
          [
            a.for("main-drawer"),
            a.aria_label("close sidebar"),
            a.class("drawer-overlay"),
          ],
          [],
        ),
        h.div(
          [
            a.class("flex min-h-full flex-col items-start bg-base-200 w-64"),
          ],
          [
            h.ul(
              [a.class("menu w-full grow")],
              list.map(menu_items, fn(item) {
                h.li([], [
                  h.a(
                    [
                      a.href(item.2),
                      a.attribute(
                        "onclick",
                        "document.getElementById(\"main-drawer\").checked = false",
                      ),
                      a.classes([#("menu-active", ctx.request.path == item.2)]),
                    ],
                    [
                      item.0([a.class("inline-block size-4")]),
                      h.span([], [
                        h.text(item.1),
                      ]),
                    ],
                  ),
                ])
              }),
            ),
          ],
        ),
      ]),
    ]),
  ])
}
