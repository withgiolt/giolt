CREATE TABLE `projects` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`slug` text NOT NULL,
	`pull_zone_id` text NOT NULL,
	`owner_id` text,
	`type` text DEFAULT 'static' NOT NULL,
	`server_id` integer,
	FOREIGN KEY (`owner_id`) REFERENCES `users`(`id`) ON UPDATE no action ON DELETE no action,
	FOREIGN KEY (`server_id`) REFERENCES `servers`(`id`) ON UPDATE no action ON DELETE no action
);
--> statement-breakpoint
CREATE UNIQUE INDEX `projects_id_unique` ON `projects` (`id`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_slug_unique` ON `projects` (`slug`);--> statement-breakpoint
CREATE UNIQUE INDEX `projects_pull_zone_id_unique` ON `projects` (`pull_zone_id`);--> statement-breakpoint
CREATE TABLE `servers` (
	`id` integer PRIMARY KEY AUTOINCREMENT NOT NULL,
	`region` text NOT NULL,
	`capacity` integer DEFAULT 1 NOT NULL
);
--> statement-breakpoint
CREATE UNIQUE INDEX `servers_id_unique` ON `servers` (`id`);--> statement-breakpoint
CREATE TABLE `users` (
	`id` text PRIMARY KEY NOT NULL,
	`billing_status` text DEFAULT 'inactive' NOT NULL,
	`billing_date` integer
);
--> statement-breakpoint
CREATE UNIQUE INDEX `users_id_unique` ON `users` (`id`);