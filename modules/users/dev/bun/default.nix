{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.bun;
in
{
	options = {
		modules.home.dev.bun = {
			enable = lib.mkEnableOption "Enable Bun environment";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			bun
		];
	};
}
