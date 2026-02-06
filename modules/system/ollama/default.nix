{ config, lib, pkgs, ... }:

let
        cfg = config.modules.system.ollama;
in
{
        options.modules.system.ollama = {
                enable = lib.mkEnableOption "Ollama LLM engine";
        };

        config = lib.mkIf cfg.enable {
                # This must be at the system level to create the 'ollama' daemon
                services.ollama = {
                        enable = true;
                };

                # Ensures the service exists but doesn't start at boot
                systemd.services.ollama.wantedBy = lib.mkForce [ ];

                environment.systemPackages = [ pkgs.ollama ];
        };
}
