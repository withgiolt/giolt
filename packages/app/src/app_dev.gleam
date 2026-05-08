import envie
import gleam/erlang/process
import mist/reload
import gleamyshell
import app

pub fn main() {
	let assert Ok(Nil) = envie.load()
	process.spawn(fn () { compile_css(dev: True) } )
	process.spawn(fn () { compile_client_javascript(dev: True) } )
	let assert Ok(_) = app.start_server(reload.wrap)
	process.sleep_forever()
}

pub fn compile_css(dev dev: Bool) {
	let _ = case dev {
		True -> gleamyshell.execute("bun", ".", ["dev:compile:css"])
		False -> gleamyshell.execute("bun", ".", ["compile:css"])
	}

	Nil
}

pub fn compile_client_javascript(dev dev: Bool) {
	let _ = case dev {
		True -> gleamyshell.execute("bun", ".", ["dev:compile:client"])
		False -> gleamyshell.execute("bun", ".", ["compile:client"])
	}

	Nil
}