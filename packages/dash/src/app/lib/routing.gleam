import gleam/uri.{type Uri}
import lustre/attribute

pub type Route {
	Index
	Login
	Account
	NotFound
}

pub fn parse_route(uri: Uri) -> Route {
	case uri.path_segments(uri.path) {
		[] | [""] -> Index
		["account"] -> Account
		["login"] -> Login
		_ -> Index
	}
}

pub fn href(route: Route) -> attribute.Attribute(t) {
	case route {
		Index -> attribute.href("/")
		Account -> attribute.href("/account")
		Login -> panic as "Not allowed to go to Login"
		NotFound -> panic as "Not allowed to go to NotFound"
	}
}
