{ config, lib, pkgs, ... }:
let
    cfg = config.modules.home.bruno;
in
{
    options = {
        modules.home.bruno = {
            enable = lib.mkEnableOption "Enable Bruno";
        };
    };

    config = lib.mkIf cfg.enable {
        home.packages = [
            pkgs.bruno
        ];
    };
}
