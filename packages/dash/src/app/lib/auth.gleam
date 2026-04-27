import gleam/javascript/promise.{type Promise}

pub type User {
	NotLoaded
	NoUser
	User(id: String, email: String)
}

@external(javascript, "./auth.ffi.ts", "validate_session")
pub fn validate_session() -> Promise(User)

@external(javascript, "./auth.ffi.ts", "create_auth_listener")
pub fn create_auth_listener(cb: fn(User) -> Nil) -> Nil

@external(javascript, "./auth.ffi.ts", "logout")
pub fn logout() -> Nil
