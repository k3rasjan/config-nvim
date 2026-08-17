return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter")
      config.setup()
      config.install({
        "lua",
        "svelte",
        "html",
        "html_tags",
        "javascript",
        "typescript",
        "python"
      })
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
