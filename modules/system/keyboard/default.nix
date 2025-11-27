{ pkgs, lib, config, ... }:

let 
	cfg = config.modules.system.keyboard;
in
{
	options.modules.system.keyboard = {
		enable = lib.mkEnableOption "Enable US International Keyboard Layout"; 
	};
	
	config = lib.mkIf cfg.enable {
		services.xserver.enable = true;
		
		services.xserver.xkb = {
			layout = "us";
			variant = "intl";
		};
		
		console.useXkbConfig = true;
	};
}
