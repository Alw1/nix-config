{
  description = "A modular NixOS flake for multiple hosts";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";  # You are using NixOS 24.11 (which is fine)
    flake-utils.url = "github:numtide/flake-utils";  # Use flake-utils for multi-system support
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [];  # Add your overlays here if needed
      };

      toasterConfig = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";  
        modules = [ ./hosts/toaster ];  
      };

    in {
      nixosConfigurations = {
        toaster = toasterConfig;  
      };
    });
}

