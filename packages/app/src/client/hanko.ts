import { Hanko, register } from "@teamhanko/hanko-elements";

const HANKO_API = "https://auth.giolt.com";
const _hanko = new Hanko(HANKO_API);
await register(HANKO_API);