import { exec } from "node:child_process";
import { watch } from "node:fs";

const createBunProcess = () => {
	return exec("bun run index.ts", (_, stdout, stderr) => {
		if (stdout) console.log(stdout);
		if (stderr) console.error(stderr);
	});
};

let bunProcess = await createBunProcess();

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
