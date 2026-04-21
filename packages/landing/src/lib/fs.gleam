import gleam/javascript/promise.{type Promise}

@external(javascript, "./external/fs", "execute")
pub fn execute(command: String) -> Promise(String)
