{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader Setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = true;

  # Fix HDMI not waking from standby (Intel Arc Graphics)
  boot.kernelParams = [
    "i915.enable_psr=0"           # Disable Panel Self Refresh
    "i915.enable_fbc=0"           # Disable framebuffer compression
  ];


  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # User Account (Passwörter/Gruppen)
  # Home Manager kümmert sich um die Apps, aber der User muss existieren
  users.users.raoul = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [ tree ];
  };
  modules.system = {
    keyboard.enable = true;
    gnome.enable = true;
    maintenance.enable = true;
    openwebui.enable = true;
    ollama.enable = true;
#    logitech.enable = true;
    display-fix.enable = true;  # Uncomment if kernel params alone don't fix it
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  # Disable ibus input method (conflicts with simple IM)
  i18n.inputMethod.enable = false;

  environment.sessionVariables = {
	GTK_IM_MODULE = "simple";
  };
  # Experimental features (Flakes) sind immer gut
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
