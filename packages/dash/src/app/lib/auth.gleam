import gleam/dynamic/decode
import gleam/javascript/promise.{type Promise}

pub type User {
	NotLoaded
	NoUser
	User(id: String, email: String, session_token: String)
}

pub type UserData {
	UserData(cli_token: String)
	UserDataNotLoaded
	UserDataNotOnboarded
	UserDataNoUser
}

pub fn user_data_decoder() -> decode.Decoder(UserData) {
	use variant <- decode.field("type", decode.string)
	case variant {
		"user_data" -> {
			use cli_token <- decode.field("cli_token", decode.string)
			decode.success(UserData(cli_token:))
		}
		"user_data_not_loaded" -> decode.success(UserDataNotLoaded)
		"user_data_no_user" -> decode.success(UserDataNoUser)
		"user_data_not_onboarded" -> decode.success(UserDataNotOnboarded)
		_ -> decode.failure(UserDataNotLoaded, "UserData")
	}
}

@external(javascript, "./auth.ffi.ts", "get_session_token")
pub fn get_session_token() -> Result(String, String)

@external(javascript, "./auth.ffi.ts", "validate_session")
pub fn validate_session() -> Promise(User)

@external(javascript, "./auth.ffi.ts", "create_auth_listener")
pub fn create_auth_listener(cb: fn(User, String) -> Nil) -> Nil

@external(javascript, "./auth.ffi.ts", "logout")
pub fn logout() -> Nil
