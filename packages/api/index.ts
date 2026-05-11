import { handle_request } from "@gleam/api/api.mjs";
import * as glen from "@gleam/glen/glen.mjs";

const server = Bun.serve({
	port: 3001,
	async fetch(request: Request) {
		const req = glen.convert_request(request);
		const response = await handle_request(req);
		if (response instanceof Response) {
			return response;
		}
		const res = glen.convert_response(response);

		return res;
	},
});

console.log(`Server is running on ${server.url}`);
