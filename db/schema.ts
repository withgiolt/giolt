import * as t from "drizzle-orm/sqlite-core";
import { sqliteTable } from "drizzle-orm/sqlite-core";

export const users = sqliteTable("users", {
	id: t.text("id").primaryKey().notNull().unique(),
	billingStatus: t
		.text("billing_status", { enum: ["active", "inactive"] })
		.notNull()
		.default("inactive"),
	billingDate: t.int("billing_date", { mode: "timestamp" }),
});

export const projects = sqliteTable("projects", {
	id: t.int("id").primaryKey({ autoIncrement: true }).unique(),
	slug: t.text("slug").notNull().unique(),
	pullZoneId: t.text("pull_zone_id").notNull().unique(),
	ownerId: t.text("owner_id").references(() => users.id),
	type: t
		.text("type", { enum: ["static", "service"] })
		.notNull()
		.default("static"),
	serverId: t.int("server_id").references(() => servers.id),
});

export type Project = typeof projects.$inferSelect;

export const servers = sqliteTable("servers", {
	id: t.int("id").primaryKey({ autoIncrement: true }).unique(),
	region: t.text("region").notNull(),
	capacity: t.int("capacity").notNull().default(1),
});

export type Server = typeof servers.$inferSelect;
