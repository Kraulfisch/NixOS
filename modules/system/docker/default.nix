{ config, lib, pkgs, ... }:
let
    cfg = config.modules.system.docker;
in 
{
    options = {
        modules.system.docker = {
            enable = lib.mkEnableOption "Enable docker";
        };
    };
    
    config = lib.mkIf cfg.enable {
        virtualisation.docker.enable = true;

        # Optional: Damit du kein 'sudo' für docker brauchst
        # users.users.deinUsername.extraGroups = [ "docker" ];

        # Allow containers to reach host services (e.g. host.docker.internal:5432).
        # Without this, nixos-fw drops new inbound connections from docker0/compose bridges.
        networking.firewall.trustedInterfaces = [ "docker0" "br-+" ];

        environment.systemPackages = [
            pkgs.docker-compose
        ];
    };
}
