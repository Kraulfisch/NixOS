{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.lunar-client;
in 
{
	options = {
		modules.home.lunar-client = {
			enable = lib.mkEnableOption "Enable lunar-client";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.lunar-client
		];
	};
}
	
