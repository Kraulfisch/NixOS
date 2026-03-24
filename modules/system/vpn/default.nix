{ config, lib, pkgs, ... }:
let
    cfg = config.modules.system.vpn;
in
{
    options = {
        modules.system.vpn = {
            enable = lib.mkEnableOption "Enable openconnect VPN";

            networkmanager = lib.mkEnableOption "Enable NetworkManager openconnect plugin (GUI support)";
        };
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ pkgs.openconnect ]
            ++ lib.optionals cfg.networkmanager [ pkgs.networkmanager-openconnect ];

        networking.networkmanager.plugins = lib.mkIf cfg.networkmanager [
            pkgs.networkmanager-openconnect
        ];
    };
}
