-- Basic settings
vim.opt.number = true
vim.opt.shiftwidth = 8
vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.termguicolors = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- Colorscheme
require("catppuccin").setup({
	flavour = "mocha",
	color_overrides = {
		mocha = {
			base = "#1e1e2e",
			mantle = "#181825",
			crust = "#11111b",
		},
	},
	integrations = {
		treesitter = true,
		native_lsp = {
			enabled = true,
		},
	},
})
vim.cmd.colorscheme("catppuccin")

-- Treesitter configuration (nvim-treesitter v1 API)
vim.api.nvim_create_autocmd('FileType', {
	callback = function(args)
		pcall(vim.treesitter.start, args.buf)
	end,
})
vim.opt.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

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
	},
	-- Point pyright at the project's uv venv (.venv/bin/python), since it
	-- won't auto-discover it and otherwise falls back to whatever `python3`
	-- is on $PATH.
	on_new_config = function(new_config, new_root_dir)
		local venv_python = new_root_dir .. '/.venv/bin/python'
		if vim.fn.executable(venv_python) == 1 then
			new_config.settings.python.pythonPath = venv_python
		end
	end,
}

vim.lsp.enable('pyright')

-- C# LSP (csharp-ls)
vim.lsp.config['csharp_ls'] = {
	cmd = { 'csharp-ls' },
	filetypes = { 'cs' },
	root_markers = { '*.sln', '*.csproj', '.git' },
	capabilities = capabilities,
}
vim.lsp.enable('csharp_ls')

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

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{
			name = 'nvim_lsp',
			max_item_count = 10
		},
	}),
	performance = {
		max_view_entries = 10
	}
})
