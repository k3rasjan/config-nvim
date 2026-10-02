return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "mason-org/mason-lspconfig.nvim",
    -- mason-lspconfig warns if mason.nvim has not been set up first.
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      -- These are *lspconfig* server names, not mason package names.
      -- Keep in sync with vim.lsp.enable() in lua/config/lsp.lua.
      -- Note: nixd is deliberately absent -- it is not in mason's registry, so
      -- listing it here would warn on every startup.
      ensure_installed = {
        'lua_ls',
        'basedpyright',
        'svelte',
        'bashls',
        'clangd',
        'jsonls',
        'tailwindcss',
        'marksman',
        'vtsls',
      },
      -- Servers are turned on explicitly in lua/config/lsp.lua instead. Leaving
      -- this on would also enable ts_ls, which is installed alongside vtsls and
      -- would attach a second client to every TypeScript/JavaScript buffer.
      automatic_enable = false,
    },
  },
}
