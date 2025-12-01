{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.geary;
in 
{
	options = {
		modules.home.geary = {
			enable = lib.mkEnableOption "Enable geary";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.geary
		];
	};
}
	
