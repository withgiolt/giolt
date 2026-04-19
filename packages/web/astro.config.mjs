// @ts-check
import preact from "@astrojs/preact";
import tailwindcss from "@tailwindcss/vite";
import { defineConfig, envField, fontProviders } from "astro/config";

import node from "@astrojs/node";

const _isDevMode = process.env.NODE_ENV === "development";

// https://astro.build/config
export default defineConfig({
	output: "server",

	vite: {
		plugins: [tailwindcss()],
	},

	server: {
		port: 3000,
		host: "0.0.0.0",
	},

	integrations: [preact()],

	env: {
		schema: {
			BETTER_AUTH_SECRET: envField.string({
				access: "secret",
				context: "server",
				optional: false,
			}),
			GH_CLIENT_ID: envField.string({
				access: "secret",
				context: "server",
				optional: false,
			}),
			GH_CLIENT_SECRET: envField.string({
				access: "secret",
				context: "server",
				optional: false,
			}),
		},
		validateSecrets: true,
	},

	fonts: [
		{
			provider: fontProviders.fontsource(),
			name: "Bricolage Grotesque",
			cssVariable: "--font-bricolage",
			display: "auto",
			weights: [200, 300, 400, 500, 600, 700, 800],
		},
	],

	devToolbar: {
		enabled: true,
	},

	security: {
		csp: true,
		checkOrigin: true,
	},

	adapter: node({
		mode: "standalone",
	}),
});
