import { exec } from "node:child_process";
import { watch } from "node:fs";
import http from "node:http";
import handler from "serve-handler";

const server = http.createServer((request, response) => {
	return handler(request, response, {
		public: "./dist",
	});
});

server.listen(3000, () => {
	console.log("Running at http://localhost:3000");
});

watch(
	new URL("./src", `file://${import.meta.path}`),
	{ recursive: true },
	async () => {
		exec("gleam run -m build", (_, stdout, stderr) => {
			console.warn("Change detected! Reloading");
			if (stdout) console.log(stdout);
			if (stderr) console.error(stderr);
		});
	},
);
