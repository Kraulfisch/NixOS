{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.brave;
in 
{
	options = {
		modules.home.brave = {
			enable = lib.mkEnableOption "Enable brave";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.brave
		];
	};
}
	
