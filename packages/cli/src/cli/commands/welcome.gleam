import cli/args.{type Args}
import clip.{type Command}
import clip/flag
import gleam/io

pub fn command() -> Command(Args) {
	clip.command({
		use help <- clip.parameter

		args.Welcome(help)
	})
	|> clip.flag(
		flag.new("help") |> flag.short("h") |> flag.help("Displays this message"),
	)
}

pub fn execute() {
	io.println("giolt")
	io.println("")
	io.println("Usage:")
	io.println("\tdeploy\t\tDeploy your project")
	io.println("")
	io.println(
		"Set the GIOLT_TOKEN environment variable to run deployments, or use the --token option",
	)
}
