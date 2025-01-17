{pkgs, lib, ... }: {
	imports = [
		./fonts.nix
		./programs.nix
		./sway.nix
	];

	nixpkgs.config.allowUnfree = true;

	nix = {
		gc = {
			automatic = true;
			dates = "weekly";
			options = "--delete-older-than 7d";
		};

		settings.experimental-features = ["nix-command" "flakes"];
	};
}
