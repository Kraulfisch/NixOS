{ config, lib, pkgs, ... }:

let
        cfg = config.modules.home.vscode;
in 
{
        options.modules.home.vscode = {
                enable = lib.mkEnableOption "Enable VS Code";
        };
        
        config = lib.mkIf cfg.enable {
                programs.vscode = {
                        enable = true;
                        package = pkgs.vscode;

                        profiles.default = {
                                extensions = with pkgs.vscode-extensions; [ ];
                                userSettings = {
                                        "workbench.colorTheme" = "Default Dark+";
                                };
                        };
                };  
        };
}
