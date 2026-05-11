import { register } from "@teamhanko/hanko-elements";

const HANKO_API = "https://auth.giolt.com";
const { hanko } = await register(HANKO_API);

hanko.onSessionCreated(() => {
	window.location.href = "/";
});

hanko.onUserLoggedOut(() => {
	window.location.href = "/login";
});

document.getElementById("hanko-logout")?.addEventListener("click", () => {
	hanko.logout();
});
