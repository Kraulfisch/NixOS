{ config, pkgs, ... }:

{
        home.username = "raoul";
        home.homeDirectory = "/home/raoul";
        home.stateVersion = "24.11"; 

        programs.home-manager.enable = true;

        modules.home = {
                git = {
                        enable = true;
                        userName = "Raoul";
                        userEmail = "raoul.sidler@vgt.energy";
                };
                brave.enable = true;
                bitwarden.enable = true;
                vscode.enable = true;
                discord.enable = true;
                neovim.enable = true;
                ghostty.enable = true;
		libreoffice.enable = true;
                spotify.enable = true;
		claude.enable = true;

                # DEV
                dev = {
                        c.enable = true;
                        python.enable = true;
                };
        };

        home.file."vgt" = {
                source = config.lib.file.mkOutOfStoreSymlink "/run/user/1000/gvfs/onedrive:host=vgt.energy,user=raoul.sidler";
        };

        dconf.settings = {
                "org/gnome/mutter" = {
                        experimental-features = [ "scale-monitor-framebuffer" ];
                };

                "org/gnome/settings-daemon/plugins/power" = {
                        sleep-inactive-ac-timeout = 0;
                        sleep-inactive-battery-timeout = 0;
                        idle-dim = false;
                };

                "org/gnome/desktop/session" = {
                        idle-delay = 0;
                };
        };
}
