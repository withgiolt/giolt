set working-directory := "."
mod db "packages/db"
mod app "packages/app"

default:
    @just --list

format:
    gleam format

[parallel]
app-dev: db::dev app::dev