import { int, sqliteTable, text } from "drizzle-orm/sqlite-core";

export const projects = sqliteTable("projects", {
	id: int().primaryKey({ autoIncrement: true }),
	slug: text().notNull(),
	serverId: int().references(() => servers.id),
});

export type Project = typeof projects.$inferSelect;

export const servers = sqliteTable("servers", {
	id: int().primaryKey({ autoIncrement: true }),
	region: text().notNull(),
	capacity: int().notNull().default(1),
});

export type Server = typeof servers.$inferSelect;
