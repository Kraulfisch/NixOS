{ config, lib, pkgs, ... }:

let
        cfg = config.modules.nvim;
in {
        options.modules.nvim = {
                enable = lib.mkEnableOption "Custom Neovim configuration";
        };

        config = lib.mkIf cfg.enable {
                programs.neovim = {
                        enable = true;
                        plugins = with pkgs.vimPlugins; [
                                # --- Syntax & Theme ---
                                (nvim-treesitter.withPlugins (p: [ p.python p.nix ]))
                                tokyonight-nvim

                                # --- LSP & Completion ---
                                nvim-lspconfig    # Links Neovim to Pyright
                                nvim-cmp          # The completion engine
                                cmp-nvim-lsp      # Lets CMP talk to the LSP
                                cmp-buffer        # Completes words from current file
                                luasnip           # Snippet engine (required by CMP)
                        ];

                        # Pyright must be installed so Neovim can find it
                        extraPackages = with pkgs; [
                                pyright
                        ];

                        extraConfig = ''
                                set termguicolors
                                colorscheme tokyonight
                                set shiftwidth=8
                                set tabstop=8

                                lua << EOF
                                local cmp = require'cmp'
                                cmp.setup({
                                        snippet = { expand = function(args) require('luasnip').lsp_expand(args.body) end },
                                        mapping = cmp.mapping.preset.insert({
                                                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                                                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                                                ['<C-Space>'] = cmp.mapping.complete(),
                                                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                                        }),
                                        sources = cmp.config.sources({
                                                { name = 'nvim_lsp' },
                                                { name = 'buffer' },
                                        })
                                })

                                -- Setup Python Language Server
                                local capabilities = require('cmp_nvim_lsp').default_capabilities()
                                require('lspconfig').pyright.setup{
                                        capabilities = capabilities
                                }
EOF
                        '';
                };
        };
}
