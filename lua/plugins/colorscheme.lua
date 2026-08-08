return {
  -- Gruvbox Colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000, -- High priority so it loads first
    config = function()
      require('gruvbox').setup()
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
