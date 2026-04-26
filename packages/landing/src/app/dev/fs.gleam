import gleam/javascript/promise.{type Promise}

@external(javascript, "./fs.ffi.ts", "execute")
pub fn execute(command: String) -> Promise(String)
