import { GH_CLIENT_ID, GH_CLIENT_SECRET } from "astro:env/server";
import { db } from "./db";
import { betterAuth } from "better-auth";
import { jwt } from "better-auth/plugins";
import { drizzleAdapter } from "better-auth/adapters/drizzle";

export const auth = betterAuth({
	plugins: [
		jwt()
	],
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
