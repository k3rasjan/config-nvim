return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure Nixd
      vim.lsp.config('nixd', {
        settings = {
          nixd = {
            nixpkgs = { expr = "import <nixpkgs> { }" },
            formatting = { command = { "alejandra" } },
          },
        },
      })

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

      -- Configure Svelte
      vim.lsp.config('svelte_ls', {})

      -- Enable the configured servers
      vim.lsp.enable({ 'nixd', 'lua_ls', 'svelte_ls' })
    end,
  },
}
