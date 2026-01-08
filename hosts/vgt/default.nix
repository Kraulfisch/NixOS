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
#    logitech.enable = true;
  };

  environment.systemPackages = with pkgs; [
    wget
  ];

  environment.sessionVariables = {
	GTK_IM_MODULE = "simple";
  };
  # Experimental features (Flakes) sind immer gut
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
