{ pkgs, config, lib, ... }:

let
	cfg = config.modules.system.cosmic;
in
{
	options = {
		modules.system.cosmic = {
			enable = lib.mkEnableOption "Enable cosmic";
		};
	};
	
	config = lib.mkIf cfg.enable {
		services.desktopManager.cosmic.enable = true;
		services.displayManager.cosmic-greeter.enable = true;
		
		};	
}

