import { readdir } from "node:fs/promises";
import * as storage from "@bunny.net/storage-sdk";

if (!Bun.env.STORAGE_ZONE || !Bun.env.STORAGE_KEY) {
	throw new Error("Environment variables for storage zone not set");
}

if (!Bun.env.LANDING_PULLZONE_ID || !Bun.env.BUNNY_API_KEY) {
	throw new Error("Environment variables for pull zone not set");
}

const storageZone = storage.zone.connect_with_accesskey(
	storage.regions.StorageRegion.Falkenstein,
	Bun.env.STORAGE_ZONE,
	Bun.env.STORAGE_KEY
)

const files = await readdir("./packages/landing/dist", { recursive: true, withFileTypes: true })

for (const file of files) {
	if (file.isFile()) {
		const pathInZone = `${file.parentPath.replace("packages/landing/dist", "")}/${file.name}`;
		console.log(pathInZone);
		await storage.file.upload(storageZone, pathInZone, Bun.file(`${file.parentPath}/${file.name}`).stream())
	}
}

console.log(await fetch(`https://api.bunny.net/pullzone/${Bun.env.LANDING_PULLZONE_ID}/purgeCache`, {
	headers: {
		"AccessKey": Bun.env.BUNNY_API_KEY
	}
}))