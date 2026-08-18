{ pkgs, config, lib, ... }:

let
  cfg = config.modules.system.nix-ld;
in
{
  options.modules.system.nix-ld = {
    enable = lib.mkEnableOption "nix-ld, a dynamic linker shim for unpatched prebuilt binaries (pip wheels, downloaded binaries)";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib # libstdc++, needed by numpy/scipy/torch et al.
      zlib
    ];
  };
}
