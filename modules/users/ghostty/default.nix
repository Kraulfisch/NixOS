{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.ghostty;
in 
{
	options = {
		modules.home.ghostty = {
			enable = lib.mkEnableOption "Enable ghostty";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.ghostty
		];
		
		home.file.".config/ghostty/config".source = ./config;
	};
}
	
