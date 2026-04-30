import { drizzle } from "drizzle-orm/libsql";
import { migrate } from "drizzle-orm/libsql/migrator";
import * as schema from "$/db/schema";
import {
	Result$Error,
	Result$Ok,
	type List,
	type Result,
} from "@gleam/prelude.mjs";
import { to_list } from "@gleam/gleam_javascript/gleam/javascript/array.mjs";
import type { Dynamic$ } from "@gleam/gleam_stdlib/gleam/dynamic.mjs";

export function get_db() {
	return drizzle({
		schema,
		connection: {
			// I don't even want to hear it...
			url: `file:${new URL("../../../../../../../../local.db", import.meta.url).pathname}`,
		},
	});
}

export async function get_db_test() {
	const db = drizzle({
		schema,
		connection: {
			url: ":memory:",
		},
	});

	await migrate(db, {
		migrationsFolder: new URL(
			"../../../../../../../../db/drizzle",
			import.meta.url,
		).pathname,
	});

	return db;
}

export async function execute(
	db: ReturnType<typeof get_db>,
	statement: string,
): Promise<Result<List<Dynamic$>, string>> {
	try {
		const res = (await db.run(statement).execute()).rows;
		return Result$Ok(to_list(res));
		// biome-ignore lint/suspicious/noExplicitAny: We need e.message
	} catch (e: any) {
		return Result$Error(e.message);
	}
}
