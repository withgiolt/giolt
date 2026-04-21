import components/carbon_badge
import gleam/int
import lustre/attribute
import lustre/element.{type Element}
import lustre/element/html

pub fn view() -> Element(t) {
	let current_year = 2026

	html.footer([attribute.class("container overflow-hidden")], [
		html.h1(
			[
				attribute.class(
					"mb-[-15%] select-none text-center font-black text-[min(36vw,480px)] leading-none bg-clip-text bg-gradient-to-t to-base-content/25 text-transparent",
				),
			],
			[html.text(" Giolt ")],
		),
		html.div([attribute.class("card glass mb-4")], [
			html.div([attribute.class("card-body gap-0")], [
				html.p([], [
					html.text(
						" Giolt "
						<> int.to_string(current_year)
						<> " Functional Source License (FSL) · Giolt contributors ",
					),
				]),
				html.a(
					[
						attribute.target("_blank"),
						attribute.class("hover:underline text-muted-foreground mb-2"),
						attribute.href("https://m4.rocks"),
					],
					[html.text(" Made with ♥ by @m4rocks ")],
				),
				carbon_badge.view(),
				html.div([attribute.class("grid grid-cols-2 md:grid-cols-4 gap-8")], [
					// html.div([], [
					// 	html.h3([attribute.class("mt-3 text-xl font-bold")], [
					// 		html.text(" About "),
					// 	]),
					// 	html.div(
					// 		[
					// 			attribute.class(
					// 				"text-muted-foreground *:hover:underline *:block",
					// 			),
					// 		],
					// 		[
					// 			html.a([attribute.href("/updates")], [html.text(" Updates ")]),
					// 		],
					// 	),
					// ]),
					html.div([], [
						html.h3([attribute.class("mt-3 text-xl font-bold")], [
							html.text(" Contribute "),
						]),
						html.div(
							[
								attribute.class(
									"text-muted-foreground *:hover:underline *:block",
								),
							],
							[
								html.a(
									[
										attribute.target("_blank"),
										attribute.href("https://github.com/withgiolt/giolt"),
									],
									[html.text("GitHub")],
								),
								html.a(
									[
										attribute.target("_blank"),
										attribute.href(
											"https://github.com/withgiolt/giolt/blob/main/LICENCE.md",
										),
									],
									[html.text("Licence")],
								),
								html.a([attribute.href("/code-of-conduct")], [
									html.text("Code of Conduct"),
								]),
							],
						),
					]),
					html.div([], [
						html.h3([attribute.class("mt-3 text-xl font-bold")], [
							html.text(" Connect "),
						]),
						html.div(
							[
								attribute.class(
									"text-muted-foreground *:hover:underline *:block",
								),
							],
							[
								html.a(
									[
										attribute.target("_blank"),
										attribute.href("https://instagram.com/withgiolt"),
									],
									[html.text(" Instagram ")],
								),
								html.a(
									[
										attribute.target("_blank"),
										attribute.href("https://facebook.com/withgiolt"),
									],
									[html.text(" Facebook ")],
								),
							],
						),
					]),
				]),
				html.a(
					[
						attribute.href("https://gleam.run"),
						attribute.target("_blank"),
						attribute.class(
							"ml-auto mt-2 badge badge-soft border-pink-300 shadow-pink-300/25 shadow-lg",
						),
					],
					[
						html.img([
							attribute.class("w-4 h-4"),
							attribute.src("/lucy.svg"),
							attribute.alt("Gleam logo"),
						]),
						html.text("Powered by Gleam"),
					],
				),
			]),
		]),
	])
}
