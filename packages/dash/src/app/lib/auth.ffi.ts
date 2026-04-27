import {
	User$NoUser,
	User$User,
	type User$,
} from "@gleam/app/app/lib/auth.mjs";
import { Hanko, register } from "@teamhanko/hanko-elements";

const HANKO_API = "https://auth.giolt.com";
const hanko = new Hanko(HANKO_API);
await register(HANKO_API);


export function create_auth_listener(fun: (arg0: User$) => void) {
	hanko.onAfterStateChange((det) => {
		if (det.state.name === "success") {
			if (
				det.state.payload?.user.user_id &&
				det.state.payload.claims.email?.address
			)
				fun(
					User$User(
						det.state.payload?.user.user_id,
						det.state.payload.claims.email.address,
					),
				);
		}
	});

	hanko.onUserLoggedOut(() => {
		fun(User$NoUser());
	});
}

export async function validate_session() {
	const session = await hanko.validateSession()
		.catch((err) => {
			console.error(err);
			return { is_valid: false, claims: { email: { address: "" } }, user_id: "" }
		});

	if (session.is_valid && session.claims?.email && session.user_id) {
		return User$User(session.user_id, session.claims.email.address);
	} else {
		return User$NoUser();
	}
}


export function logout() {
	hanko.logout()
}