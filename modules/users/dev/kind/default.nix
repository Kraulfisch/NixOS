{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.kind;
in
{
	options = {
		modules.home.dev.kind = {
			enable = lib.mkEnableOption "Enable Kind (Kubernetes in Docker)";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.kind
		];
	};
}
