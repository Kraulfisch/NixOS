{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.docker;
in 
{
	options = {
		modules.home.docker = {
			enable = lib.mkEnableOption "Enable docker";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.docker
		];
	};
}
	
