import { GH_CLIENT_ID, GH_CLIENT_SECRET } from "astro:env/server";
import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { db } from "./db";

export const auth = betterAuth({
	database: drizzleAdapter(db, {
		provider: "sqlite",
	}),
	socialProviders: {
		github: {
			clientId: GH_CLIENT_ID,
			clientSecret: GH_CLIENT_SECRET,
		},
	},
});
