{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.claude;
in 
{
	options = {
		modules.home.claude = {
			enable = lib.mkEnableOption "Enable claude";
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.claude-code
		];
	};
}
	
