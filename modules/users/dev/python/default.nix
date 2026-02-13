{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.dev.python;
in
{
        options.modules.home.dev.python = {
                enable = mkEnableOption "Python development environment";
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        (python3.withPackages (ps: with ps; [
                                requests
                                setuptools
                        ]))
                ];

		programs.direnv = {
			enable = true;
			nix-direnv.enable = true;
		};

		programs.bash.enable = true;
		programs.zsh.enable = true;
        };
}
