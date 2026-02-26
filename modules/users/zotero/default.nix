{ config, lib, pkgs, ... }:

with lib;

let
        cfg = config.modules.home.zotero;
in
{
        options.modules.home.zotero = {
                enable = mkEnableOption "Zotero bibliography manager";
        };

        config = mkIf cfg.enable {
                home.packages = with pkgs; [
                        zotero
                ];

                # Note: Most Zotero-LaTeX workflows rely on the 'Better BibTeX' 
                # extension. While extensions are usually managed within Zotero, 
                # ensuring the package is here is the first step.
        };
}
