import envie
import gleam/dict
import gleam/httpc
import gleam/list
import gleam/option
import gleam/result
import gleam/string
import httplibsql

pub type Project {
  Project(
    id: String,
    slug: String,
    pull_zone_id: String,
    owner_id: String,
    type_: ProjectType,
    server_id: String,
  )
}

pub type ProjectType {
  Static
  Service
}

pub type Server {
  Server(id: Int, region: String, capacity: Int)
}

pub type User {
  User(
    id: String,
    billing_status: UserBillingStatus,
    billing_date: Int,
    cli_token: String,
  )
}

pub type UserBillingStatus {
  Active
  Inactive
}

pub fn execute(statement: String) {
  let url = envie.get_string("DB_URL", "http://localhost:3100/v2/pipeline")
  let token = envie.get_string("DB_TOKEN", "")
  let base_request =
    httplibsql.new_request()
    |> httplibsql.with_url(url)
    |> httplibsql.with_token(token)

  let req =
    base_request
    |> httplibsql.with_statement(httplibsql.ExecuteStatement(
      query: statement,
      arguments: option.None,
    ))
    |> httplibsql.with_statement(httplibsql.CloseStatement)
    |> httplibsql.build
  let assert Ok(req) = req

  use res <- result.try(
    httpc.send(req) |> result.replace_error("Couldn't reach database"),
  )

  use _ <- result.try(case string.contains(res.body, "\"type\":\"error\"") {
    True -> Error("Database returned error: " <> res.body)
    False -> Ok(Nil)
  })

  use decoded_res <- result.try(
    httplibsql.decode_response(res.body)
    |> result.replace_error("Failed to decode response"),
  )

  case decoded_res.results {
    [res, ..] -> {
      case res {
        httplibsql.ExecuteResponse(cols, rows) ->
          Ok({
            list.map(rows, fn(row) {
              list.map2(cols, row.values, fn(col, value) { #(col, value) })
              |> dict.from_list
            })
          })
        httplibsql.CloseResponse -> Error("Malformed response")
      }
    }
    _ -> Error("Failed to get results")
  }
}

pub fn as_server(
  rows: List(dict.Dict(httplibsql.Column, httplibsql.Value)),
) -> List(Server) {
  list.map(rows, fn(row) {
    let assert httplibsql.Integer(id) =
      row
      |> dict.get(httplibsql.Column("id", "INTEGER"))
      |> result.unwrap(httplibsql.Integer(0))

    let assert httplibsql.Text(region) =
      row
      |> dict.get(httplibsql.Column("region", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Integer(capacity) =
      row
      |> dict.get(httplibsql.Column("capacity", "INTEGER"))
      |> result.unwrap(httplibsql.Integer(0))

    Server(id:, region:, capacity:)
  })
}

pub fn as_user(
  rows: List(dict.Dict(httplibsql.Column, httplibsql.Value)),
) -> List(User) {
  list.map(rows, fn(row) {
    let assert httplibsql.Text(id) =
      row
      |> dict.get(httplibsql.Column("id", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Text(billing_status_raw) =
      row
      |> dict.get(httplibsql.Column("billing_status", "TEXT"))
      |> result.unwrap(httplibsql.Text("inactive"))

    let billing_status = case billing_status_raw {
      "active" -> Active
      "inactive" -> Inactive
      _ -> panic as "Invalid billing_status"
    }

    let assert httplibsql.Integer(billing_date) =
      row
      |> dict.get(httplibsql.Column("billing_date", "INTEGER"))
      |> result.unwrap(httplibsql.Integer(0))

    let assert httplibsql.Text(cli_token) =
      row
      |> dict.get(httplibsql.Column("cli_token", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    User(id:, billing_status:, billing_date:, cli_token:)
  })
}

pub fn as_project(
  rows: List(dict.Dict(httplibsql.Column, httplibsql.Value)),
) -> List(Project) {
  list.map(rows, fn(row) {
    let assert httplibsql.Text(id) =
      row
      |> dict.get(httplibsql.Column("id", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Text(slug) =
      row
      |> dict.get(httplibsql.Column("slug", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Text(pull_zone_id) =
      row
      |> dict.get(httplibsql.Column("pull_zone_id", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Text(owner_id) =
      row
      |> dict.get(httplibsql.Column("owner_id", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    let assert httplibsql.Text(type_raw) =
      row
      |> dict.get(httplibsql.Column("type", "TEXT"))
      |> result.unwrap(httplibsql.Text("static"))

    let type_ = case type_raw {
      "static" -> Static
      "service" -> Service
      _ -> panic as "Invalid project type"
    }

    let assert httplibsql.Text(server_id) =
      row
      |> dict.get(httplibsql.Column("server_id", "TEXT"))
      |> result.unwrap(httplibsql.Text("0"))

    Project(id:, slug:, pull_zone_id:, owner_id:, type_:, server_id:)
  })
}
