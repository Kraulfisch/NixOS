{ config, pkgs, ... }:

{
  home.username = "raoul";
  home.homeDirectory = "/home/raoul";
  home.stateVersion = "25.11"; 
  
  imports = [
	../../modules/users/git/default.nix
  ];
  home.packages = [
  
  ];

  home.file = {
 
  };
  
  modules.home.git = {
	enable = true;
	userName = "Raoul";
	userEmail = "raoul.sidler@gmx.ch";
  };
	
  home.sessionVariables = {
 
  };
	
  programs.bash = {
	enable = true;
	shellAliases = 
	{
		ll = "ls -l";
	};
  };
  programs.home-manager.enable = true;
}
