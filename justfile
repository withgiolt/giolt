mod db
set shell := ["bash", "-cu"]

default:
    @just --list

format:
    gleam format
