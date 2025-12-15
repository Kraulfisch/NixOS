{
        description = "Modular NixOS Configuration";

        inputs = {
                nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

                home-manager.url = "github:nix-community/home-manager";
                home-manager.inputs.nixpkgs.follows = "nixpkgs";
        };

        outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
                lib = nixpkgs.lib;
                system = "x86_64-linux";

                hosts = builtins.attrNames (builtins.readDir ./hosts);
        in
        {
                nixosConfigurations = builtins.listToAttrs (
                        map (host: {
                                name = host;
                                value = lib.nixosSystem {
                                        inherit system;

                                        specialArgs = {
                                                inherit inputs;
                                                hostName = host;
                                        };

                                        modules = [
                                                {
                                                        networking.hostName = host;
                                                        # Hier aktivieren wir Unfree-Pakete für das ganze System
                                                        nixpkgs.config.allowUnfree = true;
                                                }
                                                (./hosts + "/${host}")
                                                ./modules/system

                                                inputs.home-manager.nixosModules.home-manager
                                                {
                                                        home-manager.useGlobalPkgs = true;
                                                        home-manager.useUserPackages = true;

                                                        home-manager.extraSpecialArgs = {
                                                                inherit inputs;
                                                        };

                                                        home-manager.sharedModules = [
                                                                ./modules/users
                                                        ];

                                                        home-manager.users.raoul = import (./hosts + "/${host}/home.nix");
                                                }
                                        ];
                                };
                        }) hosts
                );
        };
}
