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

  # RTX 3060: use proprietary driver instead of nouveau
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
  };

  # Timezone
  time.timeZone = "Europe/Amsterdam";

  # User Account (Passwörter/Gruppen)
  # Home Manager kümmert sich um die Apps, aber der User muss existieren
  users.users.raoul = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "plugdev" ];
    packages = with pkgs; [ tree ];
  };
  modules.system = {
    core-tools.enable = true;
    keyboard.enable = true;
    gnome.enable = true;
    maintenance.enable = true;
    openwebui.enable = true;
    docker.enable = true;
    ollama.enable = true;
#    logitech.enable = true;
    vpn.enable = true;
    netbird.enable = true;
    network-tools.enable = true;
    nix-ld.enable = true;
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
