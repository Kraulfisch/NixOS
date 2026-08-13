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
			pkgs.pyright  # Python language server
			pkgs.csharp-ls  # C# language server
		];

		# Deliver plugins via packpath - programs.neovim.plugins doesn't
		# generate plugin paths in the wrapper with useUserPackages = true
		xdg.dataFile = with pkgs.vimPlugins; {
			"nvim/site/pack/nix/start/catppuccin-nvim".source = catppuccin-nvim;
			"nvim/site/pack/nix/start/nvim-treesitter".source = nvim-treesitter.withAllGrammars;
			"nvim/site/pack/nix/start/nvim-lspconfig".source = nvim-lspconfig;
			"nvim/site/pack/nix/start/nvim-cmp".source = nvim-cmp;
			"nvim/site/pack/nix/start/cmp-nvim-lsp".source = cmp-nvim-lsp;
		};

		programs.neovim = {
			enable = true;
			vimAlias = true;
			withRuby = false;
			withPython3 = false;

			initLua = builtins.readFile ./init.lua;
		};

		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};
}
	
