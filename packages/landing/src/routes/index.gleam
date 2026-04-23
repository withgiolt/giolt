import layouts/default_layout
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
  default_layout.view(default_layout.LayoutAttrs(title: "Giolt"), [
    html.div(
      [attribute.class("container min-h-128 flex flex-col justify-center")],
      [
        html.div([attribute.class("flex flex-row gap-1 mb-2")], [
          html.span([attribute.class("badge badge-soft")], [
            html.text("Pre-Alpha"),
          ]),
        ]),
        html.h1([attribute.class("font-black text-4xl md:text-7xl mb-2")], [
          html.text(" The "),
          html.span([attribute.class("highlight")], [html.text("fair")]),
          html.text(" web hosting provider. "),
        ]),
        html.p([attribute.class("text-base-content/50 mb-4")], [
          html.text(
            " The privacy-focused, fair priced and performant alternative to traditional web hosting providers. ",
          ),
        ]),
        html.div([attribute.class("flex flex-row items-center gap-2")], [
          html.button(
            [
              attribute.class("btn"),
              attribute.disabled(True),
              attribute.type_("button"),
            ],
            [html.text(" Coming soon ")],
          ),
        ]),
      ],
    ),
    html.div([attribute.class("container")], [
      html.div([attribute.class("grid grid-cols-1 md:grid-cols-2 gap-2")], [
        html.div([attribute.class("card glass bg-base-200 shadow")], [
          html.div([attribute.class("card-body")], [
            html.h2([attribute.class("card-title")], [
              html.text("Choose your region"),
            ]),
            html.p([], [html.text("With regions such as:")]),
            html.ul([], [
              html.li([], [html.text("🇩🇪 Nuremberg, Germany")]),
              html.li([], [html.text("🇫🇮 Helsinki, Finland")]),
              html.li([], [html.text("🇫🇷 Gravelines, France")]),
              html.li([], [html.text("🇨🇦 Beauharnois, Canada")]),
              html.li([], [html.text("🇦🇺 Sydney, Australia")]),
              html.text(" ...and more coming soon "),
            ]),
          ]),
        ]),
        html.div([attribute.class("card glass bg-base-200 shadow")], [
          html.div([attribute.class("card-body")], [
            html.h2([attribute.class("card-title")], [
              html.text("Gleam centered"),
            ]),
            html.p([], [
              html.text(
                "The dedicated place for Gleam developers. Built with Gleam, for Gleam.",
              ),
            ]),
          ]),
        ]),
        html.div([attribute.class("card glass bg-base-200 shadow")], [
          html.div([attribute.class("card-body")], [
            html.h2([attribute.class("card-title")], [
              html.text("Fair open source"),
            ]),
            html.p([], [
              html.text(
                " We believe the future of open source is fair. 
							We appreciate frequent contributions via
							discounts. ",
              ),
            ]),
          ]),
        ]),
        html.div([attribute.class("card glass bg-base-200 shadow")], [
          html.div([attribute.class("card-body")], [
            html.h2([attribute.class("card-title")], [html.text("European")]),
            html.p([], [
              html.text(
                "Based in Europe, we understand the importance of data sovereignty and compliance.",
              ),
            ]),
          ]),
        ]),
      ]),
    ]),
    html.div([attribute.id("faq"), attribute.class("container my-16")], [
      html.div(
        [attribute.class("grid grid-cols-1 md:grid-cols-2 gap-6 items-start")],
        [
          html.div([attribute.class("order-1 md:order-0")], [
            html.h2([attribute.class("text-3xl md:text-5xl font-bold")], [
              html.text("FAQ"),
            ]),
            html.p([attribute.class("text-base-content/75 mt-2 mb-4")], [
              html.text(
                " Answers to common questions about Giolt. Click a question to expand. ",
              ),
            ]),
            html.p([attribute.class("text-base-content/70")], [
              html.text(
                " If you don't find your question here, reach out to us. ",
              ),
            ]),
          ]),
          html.div([attribute.class("order-2")], [
            html.div(
              [attribute.class("card bg-base-200 text-base-content p-4")],
              [
                html.div([attribute.class("join join-vertical")], [
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.checked(False),
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("Is it stable?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          " While Giolt is still in its early stages, we are committed to ensuring its stability and reliability.
									Giolt is built using Gleam at it's core, making it highly performant and safe. ",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("Can I try Giolt for free?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          " Starting out, Giolt will not offer free trials or a free plan.
									We will still have a demo account that will present how Giolt works. ",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("How do you reward contributors?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          " Giolt is open-source to it's core. To encourage contributions, we offer discounts to
									frequent contributors, or contributors that have made a lasting impact in Giolt.
									Discounts range from 50% to 90%. ",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("What about pricing?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          "We know that pricing is an important consideration for our users. We are working on a transparent pricing model that will be announced soon.
													Using various cost efficient methods, we will strive to offer competitive rates for a very decent price to performance ratio.",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("Built with Gleam?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          "Giolt is built with Gleam for Gleam. Our entire codebase is based on Gleam.",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [
                          html.text(
                            "Will there be support for other languages?",
                          ),
                        ],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          "While Giolt is currently focused on the Gleam ecosystem, there will be support for other languages in the future 
													such as: PHP, Elixir, Erlang and JavaScript (Node.js, Bun and Deno).",
                        ),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.class(
                        "collapse collapse-arrow join-item bg-base-200 border border-base-300",
                      ),
                    ],
                    [
                      html.input([
                        attribute.name("faq-accordion"),
                        attribute.type_("radio"),
                      ]),
                      html.div(
                        [attribute.class("collapse-title font-semibold")],
                        [html.text("How European is Giolt?")],
                      ),
                      html.div([attribute.class("collapse-content text-sm")], [
                        html.text(
                          "Giolt is based in Europe with it's stack built on European technologies. Keep in mind that some components, such as payment processing,
													will be using privacy focused non-european alternatives.",
                        ),
                      ]),
                    ],
                  ),
                ]),
              ],
            ),
          ]),
        ],
      ),
    ]),
  ])
}
