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
			stdlib = ''
				: ''${XDG_CACHE_HOME:=$HOME/.cache}
				declare -A direnv_layout_dirs
				direnv_layout_dir() {
				        echo "''${XDG_CACHE_HOME}/direnv/layouts/$(pwd | sha1sum | cut -d' ' -f1)"
				}
			'';	
		};

		programs.bash.enable = true;
		programs.zsh.enable = true;
        };
}
