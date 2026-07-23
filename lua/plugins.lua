-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd('packadd! nohlsearch')

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
	-- Quickstart configs for LSP
	'https://github.com/neovim/nvim-lspconfig',
	-- Fuzzy picker
	'https://github.com/ibhagwan/fzf-lua',
	-- Autocompletion
	-- 'https://github.com/nvim-mini/mini.completion',
	-- Enhanced quickfix/loclist
	'https://github.com/stevearc/quicker.nvim',
	-- Git integration
	'https://github.com/lewis6991/gitsigns.nvim',
	-- Gruvbox colorscheme
	'https://github.com/ellisonleao/gruvbox.nvim',
	-- Auto completions
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/hrsh7th/cmp-nvim-lsp',
	--Autopair
	'https://github.com/windwp/nvim-autopairs',
})

require('fzf-lua').setup { fzf_colors = true }
-- require('mini.completion').setup {}
require('quicker').setup {}
require('gitsigns').setup {}

require('gruvbox').setup()
vim.cmd.colorscheme("gruvbox")


local cmp = require('cmp')
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(), -- Manually trigger popup
		['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept completion
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
		{ name = 'nvim_lsp' }, -- Feed language server items to completion menu
	})
})

vim.lsp.config('nixd', {
	settings = {
		nixd = { nixpkgs = { expr = "import <nixpkgs> { }" } },
	},
})

-- Lua-ls
vim.lsp.config('lua_ls', {
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
			runtime = {
				version = 'LuaJIT',
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

vim.lsp.config('svelte_ls', {})

vim.lsp.enable({ 'nixd', 'lua_ls', 'svelte_ls' })
