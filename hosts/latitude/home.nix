{ config, pkgs, ... }:
{
  home.username = "raoul";
  home.homeDirectory = "/home/raoul";
  home.stateVersion = "24.11"; 
 
  programs.home-manager.enable = true;
 
  imports = [
	../../modules/users/git/default.nix
	../../modules/users/brave/default.nix
  ];
  
  modules.home = {
	git = { enable = true; userName = "Raoul"; userEmail = "raoul.sidler@gmx.ch"; };
	brave.enable = true;	
  };

	
}
