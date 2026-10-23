{ config, pkgs, ... }:

{
	home.username = "raoul";
	home.homeDirectory = "/home/raoul";
	home.stateVersion = "26.05";

	programs.home-manager.enable = true;

	modules.home = {
		git.enable = true;
		neovim.enable = true;
	};
}
