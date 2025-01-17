{ pkgs, config, inputs, ... }: with pkgs;
let programs = {
	  cliPrograms = [
		hyfetch
		gotop
		tree
		zip 
		unzip
		xz
	  ];
	  programmingUtils = [
		vim 
		neovim
		vscode
		git
		gnumake
		gcc
		ghc
		go
		jdk
		rustc
		cargo
		cabal-install
	  ];
	  video = [
		vlc
	  ];
	  miscPrograms = [
		spotify
		mongodb-compass
		discord
		melonDS
		snes9x
	  ];
	};
in {
  environment.systemPackages = lib.concatLists (lib.attrValues programs);
}
