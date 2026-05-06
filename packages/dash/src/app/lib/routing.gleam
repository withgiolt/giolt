import gleam/uri.{type Uri}
import lustre/attribute

pub type Route {
	Index
	Login
	Onboard
	Account
	Cli
	NotFound
}

pub fn parse_route(uri: Uri) -> Route {
	case uri.path_segments(uri.path) {
		[] | [""] -> Index
		["account"] -> Account
		["cli"] -> Cli
		["login"] -> Login
		["onboard"] -> Onboard
		_ -> Index
	}
}

pub fn href(route: Route) -> attribute.Attribute(t) {
	case route {
		Index -> attribute.href("/")
		Account -> attribute.href("/account")
		Onboard -> panic as "Not allowed to go to Onboard"
		Login -> panic as "Not allowed to go to Login"
		Cli -> attribute.href("/cli")
		NotFound -> panic as "Not allowed to go to NotFound"
	}
}
