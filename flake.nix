{
	description = "I use NixOS btw";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
		home-manager.url = "github:nix-community/home-manager/release-25.11";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";
	};

	outputs = { self, nixpkgs, home-manager, ... }: 
	let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
		pkgs = nixpkgs.legacyPackages.${system};
	in
	 {
		nixosConfigurations = {
			nixos-btw = lib.nixosSystem {
				inherit system;
				modules = 
				[
					./hosts/latitude/configuration.nix		
				];
			};
		};

		homeConfigurations = {
			raoul = home-manager.lib.homeManagerConfiguration {
				inherit pkgs;
				modules = [ ./hosts/latitude/home.nix ];
			};
		};
	};

}
