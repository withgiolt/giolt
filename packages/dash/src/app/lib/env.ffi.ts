import env from "@/../.env";
import { type Result, Result$Error, Result$Ok } from "@gleam/prelude.mjs";

export function get_string(variable: string): Result<string, string> {
	if (env[variable]) {
		return Result$Ok(env[variable]);
	} else {
		return Result$Error(`No environment variable named: ${variable}`);
	}
}
