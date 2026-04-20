import { betterAuth } from "better-auth";
import { db } from "./db";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { jwt } from "better-auth/plugins";

// Check GitHub secrets
if (!Bun.env.GH_CLIENT_ID || !Bun.env.GH_CLIENT_SECRET) {
	throw new Error("Missing GitHub client credentials");
}

const auth = betterAuth({
	plugins: [jwt()],
	baseURL: Bun.env.DEV === "production" ? "https://api.giolt.com" : "http://localhost:3001",
	database: drizzleAdapter(db, {
		provider: "sqlite",
	}),
	socialProviders: {
		github: {
			clientId: Bun.env.GH_CLIENT_ID,
			clientSecret: Bun.env.GH_CLIENT_SECRET,
		},
	},
});

export function get_auth() {
	return auth;
}
