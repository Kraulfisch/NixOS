{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.nodejs;
in
{
	options = {
		modules.home.dev.nodejs = {
			enable = lib.mkEnableOption "Enable Node.js environment";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			nodejs_24
		];
	};
}
