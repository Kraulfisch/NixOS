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
                                pip
                                requests
                                setuptools
                        ]))
                ];
        };
}
