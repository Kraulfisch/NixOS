{ config, lib, pkgs, ... }: 

let
	cfg = config.modules.system.maintenance;
in
{
	options.modules.system.maintenance = {
		enable = lib.mkEnableOption "Enable Maintenance";
	};

	config = lib.mkIf cfg.enable {
		boot.loader.systemd-boot.configurationLimit = 5;

		nix.gc = {
			automatic = true;
			dates = "weekly";

			options = "--delete-older-than 14d";
		};
			
		nix.settings.auto-optimise-store = true;
	};
}
