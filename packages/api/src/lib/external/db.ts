import { drizzle } from "drizzle-orm/libsql";
import * as schema from "$/db/schema";

export const db = drizzle({
	schema,
	connection: {
		// I don't even want to hear it...
		url: `file:${new URL("../../../../../../../../local.db", import.meta.url).pathname}`,
	},
});
