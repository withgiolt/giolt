DROP INDEX "projects_id_unique";--> statement-breakpoint
DROP INDEX "projects_slug_unique";--> statement-breakpoint
DROP INDEX "projects_pull_zone_id_unique";--> statement-breakpoint
DROP INDEX "servers_id_unique";--> statement-breakpoint
DROP INDEX "users_id_unique";--> statement-breakpoint
DROP INDEX "users_cli_token_unique";--> statement-breakpoint
ALTER TABLE `projects` ALTER COLUMN "pull_zone_id" TO "pull_zone_id" integer NOT NULL;--> statement-breakpoint
CREATE UNIQUE INDEX `projects_id_unique` ON `projects` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_slug_unique` ON `projects` (`slug`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_pull_zone_id_unique` ON `projects` (`pull_zone_id`);--> statement-breakpoint
CREATE UNIQUE INDEX `servers_id_unique` ON `servers` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_id_unique` ON `users` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `users_cli_token_unique` ON `users` (`cli_token`);