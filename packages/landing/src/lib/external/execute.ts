import { exec } from "node:child_process";

export function execute(command: string): Promise<{ stdout: string }> {
	return new Promise((resolve, reject) => {
		exec(command, (error, stdout) => {
			if (error) {
				reject(error);
			} else {
				resolve({ stdout });
			}
		});
	});
}
