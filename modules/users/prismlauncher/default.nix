{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.prismlauncher;
in
{
	options = {
		modules.home.prismlauncher = {
			enable = lib.mkEnableOption "Enable prismlauncher";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.prismlauncher
		];
	};
}

