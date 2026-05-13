{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.codex;
in
{
	options = {
		modules.home.codex = {
			enable = lib.mkEnableOption "Enable codex";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.codex
		];
	};
}
