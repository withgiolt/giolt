import { Glob } from "bun";

// Exclude build files
const glob = new Glob("packages/api/**/*.gleam")

for await (const file of glob.scan(".")) {
	if (file.includes("build")) {
		continue;
	}

	const f = Bun.file(file);
	const content = await f.text();
	// Replace lines that start with 2 spaces with 1 tab
	const updatedContent = content.replace(/^  /gm, "\t");
	await Bun.write(file, updatedContent);
}