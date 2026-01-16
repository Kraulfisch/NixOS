{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.geogebra;
in 
{
	options = {
		modules.home.geogebra = {
			enable = lib.mkEnableOption "Enable Geogebra";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			geogebra6
		];
	};
}
	
