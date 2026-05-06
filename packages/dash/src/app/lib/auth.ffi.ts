import {
	User$NoUser,
	User$User,
	type User$,
} from "@gleam/app/app/lib/auth.mjs";
import { Result$Error, Result$Ok, type Result } from "@gleam/prelude.mjs";
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
			) {
				const token = hanko.getSessionToken()
				fun(
					User$User(
						det.state.payload?.user.user_id,
						det.state.payload.claims.email.address,
						token
					),
				);
			}
		}
	});

	hanko.onUserLoggedOut(() => {
		fun(User$NoUser());
	});
}

export async function validate_session() {
	const session = await hanko.validateSession().catch((err) => {
		console.error(err);
		return {
			is_valid: false,
			claims: { email: { address: "" } },
			user_id: "",
		};
	});
	const token = hanko.getSessionToken();

	if (session.is_valid && session.claims?.email && session.user_id) {
		return User$User(session.user_id, session.claims.email.address, token);
	} else {
		return User$NoUser();
	}
}

export function logout() {
	hanko.logout();
}

export function get_session_token(): Result<string, string> {
	try {
		const token = hanko.getSessionToken()

		if (token) {
			return Result$Ok(token)
		} else {
			return Result$Error("No session token")
		}
	} catch(_) {
		return Result$Error("Failed to get session token")
	}
	
}