{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.dotnet;
in
{
	options = {
		modules.home.dev.dotnet = {
			enable = lib.mkEnableOption "Enable .NET development environment";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = with pkgs; [
			dotnet-sdk_10
		];

		# Workloads (e.g. wasm-tools) can't write to /nix/store, so point
		# the CLI home to a mutable user directory. After rebuilding, run:
		#   dotnet workload install wasm-tools
		home.sessionVariables = {
			DOTNET_ROOT = "$HOME/.local/share/dotnet";
			PATH = "$HOME/.local/share/dotnet:$PATH";
		};
	};
}
