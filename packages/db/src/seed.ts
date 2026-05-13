import { drizzle } from "drizzle-orm/libsql";
import { seed } from "drizzle-seed"
import * as schema from "./schema";
import { reset } from "drizzle-seed";

const db = drizzle("file:../../local.db")
// @ts-ignore
await reset(db, schema)

await db.insert(schema.servers).values({
  region: "worldwide",
  capacity: 15,
  id: 0
})
