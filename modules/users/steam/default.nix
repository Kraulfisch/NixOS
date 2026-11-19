{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.steam;
in 
{
	options = {
		modules.home.steam = {
			enable = lib.mkEnableOption "Enable steam";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.steam
		];
	};
}
	
