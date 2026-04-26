import gleam/uri.{type Uri}

pub type Route {
	Index
	Login
}

pub fn parse_route(uri: Uri) -> Route {
	case uri.path_segments(uri.path) {
		[] | [""] -> Index
		["login"] -> Login
		_ -> Index
	}
}