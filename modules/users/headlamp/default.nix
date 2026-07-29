{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.headlamp;
in
{
	options = {
		modules.home.headlamp = {
			enable = lib.mkEnableOption "Enable Headlamp Kubernetes dashboard";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.headlamp
		];
	};
}
