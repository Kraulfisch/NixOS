{ pkgs, config, lib, ... }:

let
  cfg = config.modules.system.display-fix;
in
{
  options = {
    modules.system.display-fix = {
      enable = lib.mkEnableOption "Enable display fix for HDMI wake issues";
    };
  };

  config = lib.mkIf cfg.enable {
    # Service that runs after resume to reset displays
    systemd.services.fix-hdmi-after-suspend = {
      description = "Reset displays after suspend/resume";
      after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
      wantedBy = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'sleep 2 && ${pkgs.kmod}/bin/modprobe -r i915 && ${pkgs.kmod}/bin/modprobe i915'";
      };
    };
  };
}
