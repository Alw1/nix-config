{
  inputs = {
 	 nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
	#	 home_manager.url =  "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nix' on the next line is the hostname 
    nixosConfigurations = {
		toaster = nixpkgs.lib.nixosSystem {
		  system = "x86_64-linux";
		  modules = [ ./hosts/toaster ];
		};
	};
  };
}
