import gleam/erlang/process
import mist/reload
import gleam/io
import gleam/result
import shellout
import app

pub fn main() {
	process.spawn(fn () { compile_css(dev: True) } )
	let assert Ok(_) = app.start_server(reload.wrap)
	process.sleep_forever()
}

fn compile_css(dev dev: Bool) {
	let dev_params = case dev {
		True -> ["--watch"]
		False -> ["--minify"]
	}
	let _ = shellout.command("bunx", ["@tailwindcss/cli", "--cwd", "./src", "-i", "./app/app.css", "-o", "../priv/app.css", ..dev_params], ".", [])
	|> result.map(with: fn(_) {
		io.println("Compiled Tailwind CSS")
		0
	})
	|> result.map_error(with: fn(output) {
		io.print_error(output.1)
		0
	})

	Nil
}