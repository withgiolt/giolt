import { defineConfig } from "drizzle-kit";

export default defineConfig({
	dialect: "turso",
	schema: "./db/schema.ts",
	out: "./db/drizzle",

	dbCredentials: {
		// biome-ignore lint/style/noNonNullAssertion: Database credentials always present
		url: import.meta.env.DATABASE_URL!,
		// biome-ignore lint/style/noNonNullAssertion: Database credentials always present
		authToken: import.meta.env.DATABASE_TOKEN!,
	},
});
