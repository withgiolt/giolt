import { to_js_request } from "@gleam/conversation/conversation.mjs";
import type { Request$ } from "@gleam/gleam_http/gleam/http/request.mjs";
import { betterAuth } from "better-auth";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { jwt, openAPI } from "better-auth/plugins";
import { db } from "./db.ffi";

// Check GitHub secrets
if (!Bun.env.GH_CLIENT_ID || !Bun.env.GH_CLIENT_SECRET) {
	throw new Error("Missing GitHub client credentials");
}

type BetterAuth = typeof auth;

const auth = betterAuth({
	plugins: [
		jwt(),
		openAPI({
			disableDefaultReference: true,
		}),
	],
	basePath: "/auth",
	baseURL:
		Bun.env.DEV === "production"
			? "https://api.giolt.com"
			: "http://localhost:3001",
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

export async function handle_requests<T>(
	auth: BetterAuth,
	request: Request$<T>,
): Promise<Response> {
	const jsReq: Request = to_js_request(request);
	return await auth.handler(jsReq);
}

export async function generate_openapi_schema(
	auth: BetterAuth,
): Promise<string> {
	return JSON.stringify(await auth.api.generateOpenAPISchema());
}
