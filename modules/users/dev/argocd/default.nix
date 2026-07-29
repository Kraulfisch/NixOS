{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.dev.argocd;
in
{
	options = {
		modules.home.dev.argocd = {
			enable = lib.mkEnableOption "Enable ArgoCD CLI";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.argocd
		];
	};
}
