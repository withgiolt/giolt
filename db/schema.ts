import { int, sqliteTable, text } from "drizzle-orm/sqlite-core";

export const projects = sqliteTable("projects", {
	id: int().primaryKey({ autoIncrement: true }),
	slug: text().notNull()
})