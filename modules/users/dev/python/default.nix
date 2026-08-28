{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.dev.python;
in
{
        options.modules.home.dev.python = {
                enable = mkEnableOption "Python development environment";
		# for libaries, the system module nix-ld is probably needed
		# install python directly via uv
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        uv
                ];
        };
}
