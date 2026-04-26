import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import gleam from "vite-gleam";

export default defineConfig({
	server: {
		port: 3000
	},
	plugins: [
		tailwindcss(),
		gleam()
  	],
})