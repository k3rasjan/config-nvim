-- Buffer-local LSP mappings, installed only when a server attaches to a buffer.
local function lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gO', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>ls', vim.lsp.buf.signature_help, opts)

    -- Symbols
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)

    -- Code actions
    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action, opts)
    vim.keymap.set({ 'n', 'x' }, '<leader>la', vim.lsp.buf.code_action, opts)

    -- Diagnostics (the global `<leader>d` diagnostic float lives in config/keymaps.lua)
    vim.keymap.set('n', '[d', function()
        vim.diagnostic.jump({ count = -1 })
    end, opts)
    vim.keymap.set('n', ']d', function()
        vim.diagnostic.jump({ count = 1 })
    end, opts)
    vim.keymap.set('n', '[D', function()
        vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
    end, opts)
    vim.keymap.set('n', ']D', function()
        vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
    end, opts)
end

local function on_attach(_, bufnr)
    lsp_keymaps(bufnr)
end

-- Bind on LspAttach rather than via vim.lsp.config('*').on_attach.
-- A server-specific on_attach (basedpyright ships one) *replaces* the '*' hook
-- instead of merging with it, so python buffers would lose every keymap. The
-- LspAttach event fires regardless of which hook a server uses, and it also
-- covers servers we never explicitly configured.
vim.api.nvim_create_augroup('lsp_keymaps', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
    group = 'lsp_keymaps',
    callback = function(args)
        on_attach(args.data and args.data.client, args.buf)
    end,
})

-- Highlight the symbols the server reports on the current line.
-- CursorHold only: LspAttach fires before a server's capabilities are known, and
-- not every server implements textDocument/documentHighlight.
vim.api.nvim_create_augroup('lsp_document_highlight', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
    group = 'lsp_document_highlight',
    callback = vim.lsp.buf.document_highlight,
})
vim.api.nvim_create_autocmd('CursorMoved', {
    group = 'lsp_document_highlight',
    callback = vim.lsp.buf.clear_references,
})

-- Server settings. Keep names in sync with vim.lsp.enable() below and with
-- ensure_installed in lua/plugins/mason.lua.

-- Nixd settings, kept for when nixd is available on $PATH.
-- nixd is not published in mason's registry, so it cannot be auto-installed.
-- Install it yourself (e.g. `nix profile install nixpkgs#nixd`) and re-enable it
-- in the vim.lsp.enable() list below. `rnix` is the mason-packaged alternative.
-- vim.lsp.config('nixd', {
--   settings = {
--     nixd = {
--       nixpkgs = { expr = "import <nixpkgs> { }" },
--       formatting = { command = { "alejandra" } },
--     },
--   },
-- })

-- Configure Lua Language Server
vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config('basedpyright', {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = 'standard',
            }
        }
    }
})

-- Configure Svelte
vim.lsp.config('svelte', {})

-- Enable the configured servers
vim.lsp.enable({
    'lua_ls',
    'svelte',
    'basedpyright',
    'bashls',
    'clangd',
    'jsonls',
    'tailwindcss',
    'marksman',
    'vtsls',
})
