DROP INDEX "projects_id_unique";--> statement-breakpoint
DROP INDEX "projects_slug_unique";--> statement-breakpoint
DROP INDEX "projects_pull_zone_id_unique";--> statement-breakpoint
DROP INDEX "servers_id_unique";--> statement-breakpoint
DROP INDEX "users_id_unique";--> statement-breakpoint
DROP INDEX "users_cli_token_unique";--> statement-breakpoint
ALTER TABLE `users` ALTER COLUMN "billing_date" TO "billing_date" integer NOT NULL DEFAULT '"1970-01-01T00:00:00.000Z"';--> statement-breakpoint
CREATE UNIQUE INDEX `projects_id_unique` ON `projects` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_slug_unique` ON `projects` (`slug`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_pull_zone_id_unique` ON `projects` (`pull_zone_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `servers_id_unique` ON `servers` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_id_unique` ON `users` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_cli_token_unique` ON `users` (`cli_token`);