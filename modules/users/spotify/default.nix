{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.spotify;
in
{
        options.modules.home.spotify = {
                enable = mkEnableOption "Spotify client";
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        spotify
                ];

                # Optional: You could add spicetify-nix here 
                # if you wanted to theme it later.
        };
}
