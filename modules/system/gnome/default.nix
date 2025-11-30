{ pkgs, config, lib, ... }:

let
	cfg = config.modules.system.gnome;
in
{
	options = {
		modules.system.gnome = {
			enable = lib.mkEnableOption "Enable gnome";
		};
	};
	
	config = lib.mkIf cfg.enable {
		services.xserver.displayManager.gdm.enable = true;
		services.xserver.desktopManager.gnome.enable = true;
		};	
}

