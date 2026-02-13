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
		services.displayManager.gdm.enable = true;
		services.desktopManager.gnome.enable = true;
		
		# services.gnome.gnome-keyring.enable = true;
		# security.pam.services.gdm.enableGnomeKeyring = true;
		};	
}

