{ config, lib, pkgs, ... }: 
let 
	cfg = config.modules.home.dev.c;
in
{
	options = {
		modules.home.dev.c = {
			enable = lib.mkEnableOption "Enable C environment";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			gcc
			gnumake
			cmake 
			ninja
			gdb
			valgrind
			cppcheck
			clang-tools
		];
	};
}
