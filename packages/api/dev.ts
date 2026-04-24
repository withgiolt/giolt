import { spawn, exec } from "node:child_process";
import { watch } from "node:fs";

const createBunProcess = () => {
	const process = spawn("bun run index.ts", {
		cwd: import.meta.dir,
		shell: true,
	});

	process.stdout.on("data", (data) => {
		console.log(data.toString());
	});
	process.stderr.on("data", (data) => {
		console.log(data.toString());
	});

	return process;
};

let bunProcess = createBunProcess();

if (Bun.env.DEV) {
	watch(
		new URL("./src", `file://${import.meta.path}`),
		{ recursive: true },
		async () => {
			exec("gleam build", (_, stdout, stderr) => {
				console.warn("Change detected! Reloading");
				if (stdout) console.log(stdout);
				if (stderr) console.error(stderr);

				bunProcess.kill();
				bunProcess = createBunProcess();
			});
		},
	);
}
