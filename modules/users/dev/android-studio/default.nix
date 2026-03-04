{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.dev.android-studio;
in
{
        options.modules.home.dev.android-studio = {
                enable = mkEnableOption "Android Studio development environment";
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        android-studio
                ];

                # Set up Android SDK environment variables
                home.sessionVariables = {
                        ANDROID_HOME = "$HOME/Android/Sdk";
                        ANDROID_SDK_ROOT = "$HOME/Android/Sdk";
                };

                # Add Android SDK tools to PATH
                home.sessionPath = [
                        "$HOME/Android/Sdk/platform-tools"
                        "$HOME/Android/Sdk/tools"
                        "$HOME/Android/Sdk/tools/bin"
                ];
        };
}
