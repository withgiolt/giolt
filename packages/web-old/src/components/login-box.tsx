import { authClient } from "@/lib/auth-client";

export const LoginBox = () => {
	const loginWithGitHub = () => {
		authClient.signIn.social({
			provider: "github",
			callbackURL: "/dashboard",
		});
	};

	return (
		<div class="card card-border glass">
			<div class="card-body">
				<h2 class="card-title">Login</h2>
				<button class="btn" type="button" onClick={loginWithGitHub}>
					Login with GitHub
				</button>
			</div>
		</div>
	);
};
