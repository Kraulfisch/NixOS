{ config, pkgs, ... }:
{
  home.username = "raoul";
  home.homeDirectory = "/home/raoul";
  home.stateVersion = "24.11"; 
 
  programs.home-manager.enable = true;
  
  modules.home = {
	git = { enable = true; userName = "Raoul"; userEmail = "raoul.sidler@gmx.ch"; };
	brave.enable = true;
	bitwarden.enable = true;
	vscode.enable = true;
	geary.enable = true;
	discord.enable = true;
	neovim.enable = true;
	claude.enable = true;
	ghostty.enable = true;
	geogebra.enable = true;
	blender.enable = true;
	dev.python.enable = true;


	dev = {
		c.enable = true;
	};

  };


	
}
