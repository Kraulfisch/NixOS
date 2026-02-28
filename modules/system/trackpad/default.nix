{ pkgs, lib, config, ... }:

let
  cfg = config.modules.system.trackpad;
in
{
  options.modules.system.trackpad = {
    enable = lib.mkEnableOption "Enable trackpad configuration with proper haptic feedback";
  };

  config = lib.mkIf cfg.enable {
    services.xserver.libinput = {
      enable = true;

      touchpad = {
        # Enable tap-to-click
        tapping = false;

        # Use clickfinger method (better for haptic feedback)
        # 1-finger tap = left click, 2-finger tap = right click, 3-finger tap = middle click
        clickMethod = "clickfinger";

        # Disable tap-and-drag by default (can feel weird)
        tappingDragLock = false;

        # Natural scrolling (like on macOS/phones) - set to false if you prefer traditional
        naturalScrolling = true;

        # Acceleration profile - "adaptive" is usually best for trackpads
        accelProfile = "adaptive";

        # Middle button emulation (click both buttons for middle click)
        middleEmulation = false;

        # Disable while typing to prevent accidental touches
        disableWhileTyping = true;
      };
    };
  };
}
