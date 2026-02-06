{ config, lib, pkgs, ... }:

let
        cfg = config.modules.home.ollama;
in 
{
        options = {
                modules.home.ollama = {
                        enable = lib.mkEnableOption "Enable local LLM suite";
                };
        };

        config = lib.mkIf cfg.enable {
                # This installs the ollama binary to your user profile
                home.packages = [
                        pkgs.ollama
                ];

                # Note: On NixOS, the background services usually need to be 
                # enabled in your system configuration.nix via:
                # services.ollama.enable = true;
                # services.open-webui.enable = true;
        };
}
