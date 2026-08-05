return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- The new API uses the plain 'nvim-treesitter' module name
      local config = require("nvim-treesitter")
      config.setup()
      config.install({ 'svelte' })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '<filetype>' },
        callback = function(args) vim.treesitter.start(args.buf) end,
      })
    end,
  },
}
