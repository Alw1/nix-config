# /etc/nixos/flake.nix
{
  inputs = {
 	 nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
    # NOTE: 'nix' on the next line is the hostname 
    nixosConfigurations.nix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
