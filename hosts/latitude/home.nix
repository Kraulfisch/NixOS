{ config, pkgs, ... }:
{
  home.username = "raoul";
  home.homeDirectory = "/home/raoul";
  home.stateVersion = "24.11"; 
 
  programs.home-manager.enable = true;
 
  imports = [
	../../modules/users/git/default.nix
	../../modules/users/brave/default.nix
	../../modules/users/bitwarden/default.nix
	../../modules/users/vscode/default.nix
	../../modules/users/geary/default.nix
  	../../modules/users/docker/default.nix
	../../modules/users/discord/default.nix
	../../modules/users/claude/default.nix
  ];
  
  modules.home = {
	git = { enable = true; userName = "Raoul"; userEmail = "raoul.sidler@gmx.ch"; };
	brave.enable = true;
	bitwarden.enable = true;
	vscode.enable = true;
	geary.enable = true;
	docker.enable = true;
	discord.enable = true;
	# claude.enable = true;
  };

	
}
