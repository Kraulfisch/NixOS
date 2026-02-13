{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.libreoffice;
in
{
        options.modules.home.libreoffice = {
                enable = mkEnableOption "LibreOffice productivity suite";
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        libreoffice-fresh
                        # Hunspell dictionaries for spellcheck
                        hunspell
                        hunspellDicts.en_US-large
                        # Optional: Add your local language dictionary here
                ];

                # Ensuring high-quality fonts are available for documents
                home.sessionVariables = {
                        # Forces LibreOffice to use GTK3/Qt theme integration
                        SAL_USE_VCLPLUGIN = "gtk3"; 
                };
        };
}
