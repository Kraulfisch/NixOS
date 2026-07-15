{ pkgs, config, lib, ... }:

let
  cfg = config.modules.system.network-tools;
in
{
  options = {
    modules.system.network-tools = {
      enable = lib.mkEnableOption "Enable Network Tools";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      net-tools
      arp-scan
      nmap
      tcpdump
    ];

    programs.wireshark = {
      enable = true;
      package = pkgs.wireshark;
    };

    users.users.raoul.extraGroups = [ "wireshark" ];
  };
}
