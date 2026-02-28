{ pkgs, lib, config, ... }:

let
	cfg = config.modules.system.printing;
in
{
	options.modules.system.printing = {
		enable = lib.mkEnableOption "Enable CUPS printing services";
	};

	config = lib.mkIf cfg.enable {
		# Enable CUPS to print documents
		services.printing.enable = true;

		# Enable automatic printer discovery on the network
		services.avahi = {
			enable = true;
			nssmdns4 = true;
			openFirewall = true;
		};

		# Common printer drivers
		services.printing.drivers = with pkgs; [
			gutenprint
			hplip
			cups-brother-hl1210w
		];
	};
}
