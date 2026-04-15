import { defineConfig } from "drizzle-kit";

export default defineConfig({
	dialect: "turso",
	schema: "./db/schema.ts",
	out: "./db/drizzle",
	
	dbCredentials: {
		url: "file:local.db"
	}
})