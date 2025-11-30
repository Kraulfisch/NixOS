{
  description = "I now understand Flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11"; 
    home-manager.url = "github:nix-community/home-manager/release-24.11"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations = {
      nixos-btw = lib.nixosSystem {
        inherit system;
        
        specialArgs = { inherit inputs; }; 

        modules = [
          # 2. Your Host Config
          ./hosts/latitude/configuration.nix

          # 3. The Bridge: Import Home Manager module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # 4. The Connection: Tell NixOS where your user config lives
            home-manager.users.raoul = import ./hosts/latitude/home.nix;
          }
        ];
      };
    };
  };
}
