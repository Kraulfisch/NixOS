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
        
        environment.systemPackages = [
            pkgs.docker-compose
        ];
    };
}
