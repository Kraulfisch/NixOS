{ config, pkgs, ... }:

{
  home.username = "raoul";
  home.homeDirectory = "/home/raoul";
  home.stateVersion = "25.11"; 
  
  imports = [
	../../modules/users/git/default.nix
	../../modules/users/brave/default.nix
  ];
  
  modules.home = {
	git = { enable = true; userName = "Raoul"; userEmail = "raoul.sidler@gmx.ch"; };
	brave.enable = true;	
  };

	
  programs.home-manager.enable = true;
}
