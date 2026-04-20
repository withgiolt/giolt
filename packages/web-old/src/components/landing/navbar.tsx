import { useSignal } from "@preact/signals";
import { useEffect } from "preact/hooks";
import { DynamicLogo } from "../dynamic-logo";

export const Navbar = () => {
	const colorClasses = useSignal("bg-base-100 text-base-content");

	useEffect(() => {
		document.addEventListener("scroll", () => {
			if (document.documentElement.scrollTop > 24) {
				colorClasses.value = "shadow-lg bg-base-content text-base-100";
			} else {
				colorClasses.value = "bg-base-100 text-base-content";
			}
		});
	});

	return (
		<nav
			class={`fixed bg-base-100 w-full p-2 transition-colors z-50 ${colorClasses}`}
		>
			<div class="container flex flex-row gap-2 items-center">
				<a href="/" class="btn btn-circle btn-ghost">
					<DynamicLogo />
				</a>
			</div>
		</nav>
	);
};

<script></script>;
