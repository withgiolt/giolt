import app/lib/makeshift
import lustre/element/html

pub fn view(ctx: makeshift.RouteContext) {
	let el = html.p([], [html.text("Not found!")])
	
	makeshift.return(el, ctx)
}