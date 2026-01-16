{ lib, ... }:

with lib;
let
        folder = ./.;
        files = builtins.readDir folder;
        filterValid = name: type:
                name != "default.nix" &&
                !hasPrefix "." name;  

        validFiles = filterAttrs filterValid files;
        
        paths = map (name: folder + "/${name}") (attrNames validFiles);
in
{
        imports = paths;
}
