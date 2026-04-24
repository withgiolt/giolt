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
						[html.text("Coming soon")],
					),
					html.a([attribute.class("btn btn-outline"), attribute.href("/updates")], [
						html.text("Updates"),
					]),
				]),
			],
		),
		html.img([
			attribute.src("/wave.svg"),
			attribute.alt(""),
			attribute.class("w-full"),
		]),
		html.div([attribute.class("bg-primary")], [
			html.div([attribute.class("container")], [
				html.h2(
					[
						attribute.class(
							"text-4xl font-bold mb-8 text-center text-primary-content",
						),
					],
					[
						html.text("Why Giolt?"),
					],
				),
				html.div(
					[
						attribute.class(
							"grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4",
						),
					],
					[
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("text-4xl")], [html.text("🚀")]),
								html.h2([attribute.class("card-title")], [
									html.text("Global CDN"),
								]),
								html.p([], [html.text("Ship fast. Everywhere.")]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("text-4xl")], [html.text("💰")]),
								html.h2([attribute.class("card-title")], [
									html.text("Predictable Pricing"),
								]),
								html.p([], [html.text("No surprises. Just honest pricing.")]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("text-4xl")], [html.text("⚡")]),
								html.h2([attribute.class("card-title")], [
									html.text("Gleam Centered"),
								]),
								html.p([], [html.text("Built with Gleam. For Gleam.")]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("text-4xl")], [html.text("🔥")]),
								html.h2([attribute.class("card-title")], [
									html.text("Performance"),
								]),
								html.p([], [
									html.text("Lightning fast response times. Do more with less."),
								]),
							]),
						]),
					],
				),
				html.div(
					[
						attribute.class(
							"divider before:bg-primary-content after:bg-primary-content text-primary-content",
						),
					],
					[html.text("Coming Soon")],
				),
				html.div(
					[
						attribute.class(
							"grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4",
						),
					],
					[
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("badge badge-warning mb-2")], [
									html.text("Coming Soon"),
								]),
								html.span([attribute.class("text-4xl")], [html.text("🌍")]),
								html.h2([attribute.class("card-title")], [
									html.text("Regional Hosting"),
								]),
								html.p([], [
									html.text("Your users deserve a server around the corner."),
								]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("badge badge-warning mb-2")], [
									html.text("Coming Soon"),
								]),
								html.span([attribute.class("text-4xl")], [html.text("🔧")]),
								html.h2([attribute.class("card-title")], [
									html.text("API Hosting"),
								]),
								html.p([], [html.text("Run your Gleam backends. Full stop.")]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("badge badge-warning mb-2")], [
									html.text("Coming Soon"),
								]),
								html.span([attribute.class("text-4xl")], [html.text("🔄")]),
								html.h2([attribute.class("card-title")], [
									html.text("SSR Lustre"),
								]),
								html.p([], [
									html.text("Interactivity meets SEO. The best of both worlds."),
								]),
							]),
						]),
						html.div([attribute.class("card card-border glass text-primary-content shadow")], [
							html.div([attribute.class("card-body items-center text-center")], [
								html.span([attribute.class("badge badge-warning mb-2")], [
									html.text("Coming Soon"),
								]),
								html.span([attribute.class("text-4xl")], [html.text("📄")]),
								html.h2([attribute.class("card-title")], [
									html.text("SPA Prerendering"),
								]),
								html.p([], [html.text("Ship instantly. Rank higher.")]),
							]),
						]),
					],
				),
			]),
		]),
		html.img([
			attribute.src("/wave.svg"),
			attribute.alt(""),
			attribute.class("w-full rotate-180"),
		]),
		html.div([attribute.class("container my-16")], [
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
													"We strive to offer competitive rates for a very decent price to performance ratio. Our pricing model is transparent and designed
													to provide value to our users while keeping surprises out.",
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
		html.div([attribute.class("container py-16")], [
			html.div([attribute.class("bg-primary rounded-3xl p-8 md:p-12")], [
				html.h2(
					[
						attribute.class(
							"text-4xl font-bold text-center mb-2 text-primary-content",
						),
					],
					[html.text("Pricing")],
				),
				html.p([attribute.class("text-center text-primary-content/70 mb-12")], [
					html.text(
						"Simple and straightforward pricing. No alarms and no surprises.",
					),
				]),
				html.div([attribute.class("grid grid-cols-1 md:grid-cols-4 gap-4")], [
					html.div(
						[
							attribute.class(
								"card md:col-span-2 border-2! border-primary-content! glass text-primary-content shadow-xl",
							),
						],
						[
							html.div([attribute.class("card-body")], [
								html.p([attribute.class("text-2xl text-bold")], [
									html.text("5€/month"),
								]),
								html.p([attribute.class("text-lg")], [html.text("Base plan")]),
								html.ul([attribute.class("list-inside")], [
									html.li([], [html.text("✓ Up to 20 static sites")]),
									html.li([], [html.text("✓ 1 service")]),
									html.li([], [html.text("✓ Unlimited requests")]),
									html.li([], [html.text("✓ 100GB shared bandwidth")]),
								]),
							]),
						],
					),
					html.div(
						[attribute.class("card glass text-primary-content shadow-lg")],
						[
							html.div([attribute.class("card-body")], [
								html.p([attribute.class("text-2xl text-bold")], [
									html.text("+2€/month"),
								]),
								html.p([attribute.class("text-lg")], [
									html.text("Bandwidth Addon"),
								]),
								html.p([], [
									html.text("✓ Adds an additional 100GB shared bandwidth"),
								]),
							]),
						],
					),
					html.div(
						[attribute.class("card glass text-primary-content shadow-lg")],
						[
							html.div([attribute.class("card-body")], [
								html.p([attribute.class("text-2xl text-bold")], [
									html.text("+3€/month"),
								]),
								html.p([attribute.class("text-lg")], [
									html.text("Service Addon"),
								]),
								html.p([], [html.text("✓ Adds an additional 1 service")]),
							]),
						],
					),
				]),
				html.div([attribute.class("flex justify-center mt-8")], [
					html.button(
						[
							attribute.class("btn btn-outline"),
							attribute.disabled(True),
							attribute.type_("button"),
						],
						[html.text(" Coming Soon ")],
					),
				]),
			]),
		]),
	])
}
