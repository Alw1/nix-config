{
  description = "Alex Wyatt's NixOS Setup";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
      system = "x86_64-linux";

      unstablePkgs = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

    in
    {
      nixosConfigurations = {

        rotom = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/rotom
            { nixpkgs.config.allowUnfree = true; }
            { _module.args.unstablePkgs = unstablePkgs; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.alex = import ./home/alex.nix;
            }
          ];
        };

        toaster = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/toaster
            { nixpkgs.config.allowUnfree = true; }
            { _module.args.unstablePkgs = unstablePkgs; }
          ];
        };
      };
    };
}


# {
#   description = "Your NixOS configuration";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#     home-manager.url = "github:nix-community/home-manager";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";
#   };
#
#   outputs = { self, nixpkgs, home-manager, ... }@inputs: {
#     nixosConfigurations = {
#       rotom = nixpkgs.lib.nixosSystem {
#         system = "x86_64-linux";
#         modules = [
#           ./hosts/rotom
#           ./common
#           ({ config, pkgs, ... }: {
#             users.users.alex = (import ./users/alex).user;
#             home-manager.users.alex = (import ./users/alex).home;
#           })
#           home-manager.nixosModules.home-manager
#         ];
#       };
#       # ...other hosts
#     };
#   };
# }

