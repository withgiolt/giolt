@external(javascript, "./env.ffi.ts", "get_string")
pub fn get(var: String) -> Result(String, String)

pub fn get_unsafe(var: String) -> String {
	let assert Ok(variable) = get(var) as "Variable not found"

	variable
}

pub fn get_or(var: String, or: String) -> String {
	case get(var) {
		Ok(var) -> var
		Error(_) -> or
	}
}