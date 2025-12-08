{ pkgs, config, lib, ... }:

let
	cfg = config.modules.system.core-tools;
in
{
	options = {
		modules.system.core-tools = {
			enable = lib.mkEnableOption "Enable core-tools";
		};
	};
	
	config = lib.mkIf cfg.enable {
		environment.systemPackages = with pkgs; [
			zip
			unzip
		];	
	};	
}

