{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.kubectl;
in
{
	options = {
		modules.home.dev.kubectl = {
			enable = lib.mkEnableOption "Enable kubectl";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.kubectl
		];
	};
}
