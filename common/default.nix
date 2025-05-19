{ ... }: {
	imports = [
		./networking.nix
		./gaming.nix
		./pkgs.nix
		./hyprland.nix
		./sway.nix
		./virtualization.nix
		./zsh.nix
	];
}
