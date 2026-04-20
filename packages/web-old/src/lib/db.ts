import { drizzle } from "drizzle-orm/libsql";
import * as schema from "../../../../db/schema.ts";

export const db = drizzle({
	schema,
	connection: {
		url: `file:${new URL("../../../../local.db", import.meta.url).pathname}`,
	},
});
