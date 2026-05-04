import clip/opt.{type Opt}
import envie
import gleam/io

pub fn add_opt() -> Opt(String) {
	opt.new("token")
	|> opt.help("Authentication Token")
	|> opt.default(envie.get_string("GIOLT_TOKEN", "NONE"))
}

pub fn auth_check(auth_token: String, cb: fn() -> Nil) {
	case auth_token {
		"NONE" -> {
			io.println_error(
				"Giolt CLI couldn't find your Giolt authentication token.",
			)
			io.println_error(
				"Make sure you have the GIOLT_TOKEN environment variable set or try passing the token with --token",
			)
		}
		_token -> {
			cb()
		}
	}
}
