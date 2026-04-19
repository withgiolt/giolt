import logoG from "@/assets/logo-transparent-g.svg";
import logoStar from "@/assets/logo-transparent-star.svg";

export const DynamicLogo = () => {
	return (
		<div class="grid relative bg-[#E6E4E3] rounded-full group">
			<img
				src={logoStar.src}
				alt="Giolt Logo"
				class="absolute p-1 group-hover:animate-[spin_2s_linear_infinite]"
			/>
			<img src={logoG.src} alt="" class="relative p-1" />
		</div>
	);
};
