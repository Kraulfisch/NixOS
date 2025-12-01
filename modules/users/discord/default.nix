{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.discord;
in 
{
	options = {
		modules.home.discord = {
			enable = lib.mkEnableOption "Enable discord";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.discord
		];
	};
}
	
