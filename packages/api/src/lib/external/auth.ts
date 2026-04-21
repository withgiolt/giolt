import { to_js_request, type JsResponse$ } from "@gleam/conversation/conversation.mjs";
import type { Request$ } from "@gleam/gleam_http/gleam/http/request.mjs";
import { Response$Response, type Response$ } from "@gleam/gleam_http/gleam/http/response.mjs";
import { type List, List$Empty, List$NonEmpty } from "@gleam/prelude.mjs";
import { type Auth, betterAuth } from "better-auth";
import type { ResponseBody$ } from "@gleam/glen/glen.mjs";
import { drizzleAdapter } from "better-auth/adapters/drizzle";
import { jwt } from "better-auth/plugins";
import { db } from "./db";

// Check GitHub secrets
if (!Bun.env.GH_CLIENT_ID || !Bun.env.GH_CLIENT_SECRET) {
	throw new Error("Missing GitHub client credentials");
}

const auth = betterAuth({
	plugins: [jwt()],
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

export async function handle_requests<T>(auth: Auth, request: Request$<T>): Promise<Response> {
	const jsReq: Request = to_js_request(request)
	return await auth.handler(jsReq);
}

function arrayToList<T>(array: Array<T>): List<T> {
  let list = List$Empty<T>();
  for (const element of array) {
    list = List$NonEmpty<T>(element, list);
  }
  return list;
}
