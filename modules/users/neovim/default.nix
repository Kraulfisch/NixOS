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
		];

		programs.neovim = {
			enable = true;
			vimAlias = true;

			plugins = with pkgs.vimPlugins; [
				# Treesitter for syntax highlighting
				nvim-treesitter.withAllGrammars

				# LSP Support
				nvim-lspconfig

				# Autocompletion
				nvim-cmp
				cmp-nvim-lsp
				cmp-buffer
				cmp-path
				cmp-cmdline

				# Snippets
				luasnip
				cmp_luasnip
				friendly-snippets
			];

			extraLuaConfig = ''
				-- Basic settings
				vim.opt.number = true
				vim.opt.shiftwidth = 8
				vim.opt.tabstop = 8
                                vim.opt.softtabstop = 8
                                vim.opt.clipboard = "unnamedplus"
				vim.opt.completeopt = {'menu', 'menuone', 'noselect'}

				-- Treesitter configuration
				require('nvim-treesitter.configs').setup {
					highlight = {
						enable = true,
						additional_vim_regex_highlighting = false,
					},
					indent = {
						enable = true,
					},
				}

				-- LSP configuration
				local capabilities = require('cmp_nvim_lsp').default_capabilities()

				-- Python LSP (pyright)
				vim.lsp.config.pyright = {
					cmd = { 'pyright-langserver', '--stdio' },
					filetypes = { 'python' },
					root_markers = { 'pyrightconfig.json', 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'Pipfile', '.git' },
					capabilities = capabilities,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								useLibraryCodeForTypes = true,
								typeCheckingMode = "basic"
							}
						}
					}
				}

				vim.lsp.enable('pyright')

				-- LSP keybindings
				vim.api.nvim_create_autocmd('LspAttach', {
					group = vim.api.nvim_create_augroup('UserLspConfig', {}),
					callback = function(ev)
						local opts = { buffer = ev.buf }
						vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
						vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
						vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
						vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
						vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
						vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
						vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					end,
				})

				-- Autocompletion setup
				local cmp = require('cmp')
				local luasnip = require('luasnip')

				-- Load friendly-snippets
				require('luasnip.loaders.from_vscode').lazy_load()

				cmp.setup({
					snippet = {
						expand = function(args)
							luasnip.lsp_expand(args.body)
						end,
					},
					mapping = cmp.mapping.preset.insert({
						['<C-b>'] = cmp.mapping.scroll_docs(-4),
						['<C-f>'] = cmp.mapping.scroll_docs(4),
						['<C-Space>'] = cmp.mapping.complete(),
						['<C-e>'] = cmp.mapping.abort(),
						['<CR>'] = cmp.mapping.confirm({ select = true }),
						['<Tab>'] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_next_item()
							elseif luasnip.expand_or_jumpable() then
								luasnip.expand_or_jump()
							else
								fallback()
							end
						end, { 'i', 's' }),
						['<S-Tab>'] = cmp.mapping(function(fallback)
							if cmp.visible() then
								cmp.select_prev_item()
							elseif luasnip.jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { 'i', 's' }),
					}),
					sources = cmp.config.sources({
						{ name = 'nvim_lsp' },
						{ name = 'luasnip' },
						{ name = 'buffer' },
						{ name = 'path' },
					})
				})
			'';
		};

		home.sessionVariables = {
			EDITOR = "nvim";
		};
	};
}
	
