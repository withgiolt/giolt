import app/components/nav
import app/layouts/base_layout
import app/lib/makeshift
import gleam/list
import gleam/result
import lucide_lustre
import lustre/attribute as a
import lustre/element/html as h
import wisp

pub fn view(
  ctx: makeshift.RouteContext,
  attributes: makeshift.Attributes,
  children: makeshift.Children,
) -> makeshift.Element {
  // Icon; Item name; List of paths to highlight, first has to be the path to highlight,
  // others are other patterns to match the first subpath to
  let menu_items = [
    #(lucide_lustre.grid_2x2, "Projects", ["/", "project"]),
    #(lucide_lustre.square_terminal, "CLI", ["/cli", "cli"]),
    #(lucide_lustre.circle_user, "Account", ["/account", "account"]),
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
                      a.href(result.unwrap(list.first(item.2), "/")),
                      a.attribute(
                        "onclick",
                        "document.getElementById(\"main-drawer\").checked = false",
                      ),
                      a.classes([
                        #("menu-active", case wisp.path_segments(ctx.request) {
                          [] -> list.contains(item.2, "/")
                          [path, ..] -> list.contains(item.2, path)
                        }),
                      ]),
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
