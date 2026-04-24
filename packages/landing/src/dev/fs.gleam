import gleam/javascript/promise.{type Promise}

@external(javascript, "./fs_ffi.ts", "execute")
pub fn execute(command: String) -> Promise(String)
