{ config, lib, pkgs, ... }:
let
	cfg = config.modules.home.neovim;
in 
{
	options = {
		modules.home.neovim = {
			enable = lib.mkEnableOption "Enable Neovim";
		};
	};
	
	config = lib.mkIf cfg.enable {
		programs.neovim = {
			enable = true;
			vimAlias = true;
			
			plugins = with pkgs.vimPlugins; [
				vim-nix
				nvim-treesitter.withAllGrammars
			]

			extraLuaConfig = ''
				vim.opt.number = true;
				vim.opt.shiftwidth = 8;
			'';
		};

		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};
}
	
