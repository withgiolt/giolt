import argv
import cli/args.{type Args}
import clip.{type Command}
import gleam/io

import cli/commands/welcome

fn command() -> Command(Args) {
	clip.subcommands_with_default([], welcome.command())
}

pub fn main() -> Nil {
	let result =
		command()
		|> clip.run(argv.load().arguments)

	case result {
		Error(e) -> io.println_error(e)
		Ok(args) -> execute(args)
	}
}

fn execute(argument: Args) {
	case argument {
		args.Welcome(_) -> welcome.execute()
	}
}
