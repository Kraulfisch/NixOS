{ config, lib, pkgs, ... }:
let
    cfg = config.modules.system.netbird;
in
{
    options = {
        modules.system.netbird = {
            enable = lib.mkEnableOption "Enable NetBird VPN";
        };
    };

    config = lib.mkIf cfg.enable {
        services.netbird.enable = true;
    };
}
