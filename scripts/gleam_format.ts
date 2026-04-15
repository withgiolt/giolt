import { Glob } from "bun";

// Exclude build files
const glob = new Glob("packages/api/**/*.gleam");

for await (const file of glob.scan(".")) {
	if (file.includes("build")) continue;

	const f = Bun.file(file);
	const content = await f.text();

	const updatedContent = content
		.split("\n")
		.map(line => {
			// Replace leading groups of 2 spaces with tabs
			return line.replace(/^( {2})+/g, (match) => {
				const tabs = match.length / 2;
				return "\t".repeat(tabs);
			});
		})
		.join("\n");

	await Bun.write(file, updatedContent);
}