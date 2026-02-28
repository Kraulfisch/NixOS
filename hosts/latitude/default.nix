{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader Setup
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # User Account (Passwörter/Gruppen)
  # Home Manager kümmert sich um die Apps, aber der User muss existieren
  users.users.raoul = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    packages = with pkgs; [ tree ];
  };

  # HIER ist der saubere Teil:
  # Wir aktivieren nur noch die Module. Woher die kommen,
  # regelt die Flake via modules/system/default.nix.
  modules.system = {
    keyboard.enable = true;
    gnome.enable = true;
    maintenance.enable = true;
    core-tools.enable = true;
    printing.enable = true;
  };

  # Experimental features (Flakes) sind immer gut
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}
