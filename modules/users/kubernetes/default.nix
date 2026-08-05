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
			(lib.hiPrio pkgs.kubectl)
			pkgs.kind
			pkgs.minikube
			pkgs.headlamp
		];
	};
}
