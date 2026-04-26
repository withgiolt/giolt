import { User$NoUser, User$User } from "@gleam/app/app/auth.mjs";
import { Hanko, register } from "@teamhanko/hanko-elements";

const HANKO_API = "https://auth.giolt.com";
const hanko = new Hanko(HANKO_API);
await register(HANKO_API)

export async function validate_session() {
	const session = await hanko.validateSession();

	if (session.is_valid) {
		return User$User(session.user_id, session.claims.email);
	} else {
		return User$NoUser()
	}
}