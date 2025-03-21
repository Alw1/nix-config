{ pkgs, config, inputs, ... }: with pkgs;
let programs = {
	  cliPrograms = [
		hyfetch
		gotop
		tree
		ventoy-full
		stow
		zip 
		usbutils
		unzip
		xz
	  ];
	  programmingUtils = [
		vim 
		vscode
		git
		gnumake
		gcc
		ghc
		go
		jdk
		rustc
		python3
		nodejs_18
		cargo
		cabal-install
	];
	neovimUtils = [
		neovim
		rust-analyzer
		vhdl-ls
		ripgrep
		haskell-language-server
	];
	video = [
		vlc
	];
	miscPrograms = [
		spotify
		discord
		obsidian
		openconnect
		prismlauncher
		gnuradio
		gnuradioPackages.osmosdr
		soapysdr
		melonDS
		cheese
		woeusb
		snes9x
	];
};
in {
	nixpkgs.config.allowUnfree = true;
	environment.systemPackages = lib.concatLists (lib.attrValues programs);
}
