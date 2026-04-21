import gleam/javascript/promise.{type Promise}

@external(javascript, "./external/execute", "execute")
pub fn execute(command: String) -> Promise(String)
