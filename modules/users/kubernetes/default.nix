{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.kubernetes;
in
{
	options = {
		modules.home.kubernetes = {
			enable = lib.mkEnableOption "Enable Kubernetes tools (kubectl, kind, minikube, Headlamp)";
		};
	};

	config = lib.mkIf cfg.enable {
		home.packages = [
			pkgs.kubectl
			pkgs.kind
			pkgs.headlamp
			pkgs.argocd
		];
	};
}
