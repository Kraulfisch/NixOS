{ config, pkgs, lib, ... }:

let
  cfg = config.modules.system.logitech;
in
{
  options.modules.system.logitech = {
    enable = lib.mkEnableOption "Enables Logitech support";
  };

  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true; 
  };
}
