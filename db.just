set working-directory := "./packages/db"

default:
    @just --list db

dev:
    turso dev --db-file ../local.db -p 3100

migrate-local:
    bun run migrate:local

migrate-remote:
    bun run migrate:remote

studio:
    bun run studio
