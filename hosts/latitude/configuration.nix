
{ config, lib, pkgs, ... }:

{
  imports =
    [ 
	./hardware-configuration.nix
	../../modules/system/gnome/default.nix
	../../modules/system/keyboard/default.nix
    ];

 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-btw";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Europe/Amsterdam";

  users.users.raoul = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  modules.system.keyboard.enable = true;
  modules.system.gnome.enable = true;

  environment.systemPackages = with pkgs; [
	vim
	wget
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "24.11";
}

