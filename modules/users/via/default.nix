{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.via;
in
{
	options = {
		modules.home.via = {
			enable = lib.mkEnableOption "Enable VIA keyboard configurator";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.via
		];
	};
}
