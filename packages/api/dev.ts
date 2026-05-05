import { spawn, exec } from "node:child_process";
import { kill } from "kill-port-bun";
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

createBunProcess();

if (Bun.env.DEV) {
	watch(
		new URL("./src", `file://${import.meta.path}`),
		{ recursive: true },
		async () => {
			exec("gleam build", async (_, stdout, stderr) => {
				console.warn("Change detected! Reloading");
				if (stdout) console.log(stdout);
				if (stderr) console.error(stderr);
				
				// TODO: Use normal kill after oven-sh/bun#20319 is fixed
				kill(3001)
				createBunProcess();
			});
		},
	);
}
