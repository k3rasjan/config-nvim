return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      -- The new API uses the plain 'nvim-treesitter' module name
      local config = require("nvim-treesitter")
      config.setup()
      vim.api.nvim_create_autocmd('FileType', { callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })
    end,
  },
}
