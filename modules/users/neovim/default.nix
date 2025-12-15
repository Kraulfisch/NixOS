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
		home.packages = [
			pkgs.wl-clipboard
		];
                
		programs.neovim = {
			enable = true;
			vimAlias = true;
			
			plugins = with pkgs.vimPlugins; [
				nvim-treesitter.withAllGrammars
			];

			extraLuaConfig = ''
				vim.opt.number = true
				vim.opt.shiftwidth = 8
				vim.opt.tabstop = 8
                                vim.opt.softtabstop = 8
                                vim.opt.clipboard = "unnamedplus"
			'';
		};

		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};
}
	
