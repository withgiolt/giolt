import app/lib/db
import app/lib/router
import birdie
import gleam/http
import gleam/http/request
import gleam/list
import gleam/result
import gleam/string
import wisp/simulate

pub fn create_project_test() {
  let req =
    simulate.browser_request(http.Post, "/project/new")
    |> simulate.form_body([
      #("name", "test"),
      #("type", "static"),
    ])
    |> request.set_cookie("hanko", "session-token")
  let _ = router.handler(req)

  use projects <- result.try(db.execute(
    "SELECT * FROM projects WHERE slug = 'test' LIMIT 1;",
  ))

  let assert Ok(project) =
    projects
    |> db.as_project
    |> list.first

  project.slug
  |> birdie.snap("project created should have name test")

  Ok(Nil)
}

pub fn delete_project_test() {
  let req =
    simulate.browser_request(http.Post, "/project/test")
    |> simulate.form_body([
      #("operation", "delete"),
    ])
    |> request.set_cookie("hanko", "session-token")
  let _ = router.handler(req)

  use projects <- result.try(db.execute(
    "SELECT * FROM projects WHERE slug = 'test' LIMIT 1;",
  ))

  projects
  |> string.inspect
  |> birdie.snap(
    "project test should be deleted and query should return empty list",
  )

  Ok(Nil)
}
