{ config, pkgs, ... }:

{
	programs.home-manager.enable = true;

	home = {
		username = "alex";
		homeDirectory = "/home/alex";
		stateVersion = "21.05";
	};


	packages = with pkgs; [
		trash-cli
		unzip
		zip
		usbutils
		wget

		spotify
		discord
		melonDS
		xz
		hyfetch
		gotop
		ranger
		
    ];

	nixpkgs.config.allowUnfree = true;
}


