{
  description = "My Nix Setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations.toaster = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/toaster ];
    };
  };
}
