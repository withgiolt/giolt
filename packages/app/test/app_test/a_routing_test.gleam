import app/lib/db
import app/lib/router
import birdie
import gleam/http
import gleam/http/request
import gleam/int
import gleam/list
import gleam/result
import gleam/string
import wisp/simulate

pub fn unauthenticated_redirects_test() {
  let req = simulate.browser_request(http.Get, "/")
  let res = router.handler(req)

  res.status
  |> int.to_string
  |> birdie.snap("request unauthenticated results in redirect")
}

pub fn authenticated_test() {
  let req =
    simulate.browser_request(http.Get, "/")
    |> request.set_cookie("hanko", "session-token")

  let res = router.handler(req)

  res.status
  |> int.to_string
  |> birdie.snap(
    "request authenticated without user created should be redirected",
  )
}

pub fn second_authenticated_test() {
  let req =
    simulate.browser_request(http.Get, "/setting-up")
    |> request.set_cookie("hanko", "session-token")

  let res = router.handler(req)

  res.status
  |> int.to_string
  |> birdie.snap("requesting setting-up authenticated should be ok")
}

pub fn user_created_test() {
  use user_data <- result.try(db.execute(
    "SELECT * FROM users WHERE id = 'user-id' LIMIT 1;",
  ))

  let user_data =
    user_data
    |> db.as_user

  let assert Ok(user_data) = list.first(user_data)
  user_data.id
  |> string.inspect
  |> birdie.snap("user was created after setting-up was reached")

  Ok(Nil)
}

pub fn third_authenticated_test() {
  let req =
    simulate.browser_request(http.Get, "/")
    |> request.set_cookie("hanko", "session-token")

  let res = router.handler(req)

  res.status
  |> int.to_string
  |> birdie.snap(
    "subsequent authenticated requests with user created should be ok",
  )
}
