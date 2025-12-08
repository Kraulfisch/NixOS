# Save this as docker-module.nix (or whatever you prefer)
{ config, lib, pkgs, ... }:

let
  cfg = config.modules.system.docker;
in 
{
  options = {
    modules.system.docker = {
      enable = lib.mkEnableOption "Enable docker";
      userName = lib.mkOption {
        type = lib.types.str;
        description = "The user to add to the docker group";
        default = "raoul";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;
    users.users.${cfg.userName}.extraGroups = [ "docker" ];
  };
}
