{ config, lib, pkgs, ... }:

let
        cfg = config.modules.system.openwebui;
in
{
        options.modules.system.openwebui = {
                enable = lib.mkEnableOption "Open WebUI interface";
        };

        config = lib.mkIf cfg.enable {
                services.open-webui = {
                        enable = true;
                        environment = {
                                OLLAMA_API_BASE_URL = "http://127.0.0.1:11434";
                                WEBUI_AUTH = "False";
                                # Enables local voice-to-text
                                AUDIO_STT_ENGINE = "whisper";
                                WHISPER_MODEL = "base";
                        };
                };

                # Keeps it from starting at boot
                systemd.services.open-webui.wantedBy = lib.mkForce [ ];
        };
}
