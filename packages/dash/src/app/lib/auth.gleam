import gleam/javascript/promise.{type Promise}

pub type User {
	NotLoaded
	NoUser
	User(id: String, email: String)
}

@external(javascript, "./auth_ffi.mjs", "validate_session")
pub fn validate_session() -> Promise(User)