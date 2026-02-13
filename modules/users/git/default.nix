{ config, lib, pkgs, ... }:

let
	cfg = config.modules.home.git;
in 
{
	options = {
		modules.home.git = {
			enable = lib.mkEnableOption "Enable git";

			userName = lib.mkOption {
				type = lib.types.str;
				default = "Raoul";
			};
			userEmail = lib.mkOption {
				type = lib.types.str;
				default = "raoul.sidler@gmx.ch";
			};
		};
	};
	
	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.git
			pkgs.openssh
		];
	
		programs.git = {
			enable = true;
			lfs.enable = true;
			settings = {
                                user = {
                                        name = cfg.userName;
                                        email = cfg.userEmail;
                                };
				extraConfig = {
					init.defaultBranch = "main";
				};
                        };
		};	
	};
}
	
