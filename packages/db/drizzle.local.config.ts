import { defineConfig } from "drizzle-kit";

export default defineConfig({
	dialect: "turso",
	schema: "./src/schema.ts",
	out: "./drizzle",

	dbCredentials: {
		url: "file:../../local.db",
	},
});
