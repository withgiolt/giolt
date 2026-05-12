mod db "packages/db"
mod app "packages/app"
mod landing "packages/landing"

default:
    @just --list

format:
    gleam format

[parallel]
app-dev: db::dev app::dev