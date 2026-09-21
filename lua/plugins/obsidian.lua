local prefix = "<leader>o"
return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  lazy = true,
  ---@module 'obsidian'
  ---@type obsidian.config

  keys = {
    { prefix,        "<cmd>Obsidian<CR>",     desc = "Obsidian GUI" },
    { prefix .. "n", "<cmd>Obsidian new<CR>", desc = "New Note" }
  },
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    ui = { enable = false },
    workspaces = {
      {
        name = "personal",
        path = "~/documents/obsidian/personal",
      },
      {
        name = "work",
        path = "~/documents/obsidian/work",
      },
      {
        name = "school",
        path = "~/documents/obsidian/school",
      },
    },

  },
  init = function()
    -- Command AutoCompletion
    vim.api.nvim_create_autocmd("CmdlineChanged", {
      callback = function()
        local cmdline = vim.fn.getcmdline()
        if vim.fn.getcmdtype() ~= ":" then
          return
        end
        if not cmdline:match "^Obsidian[A-Za-z0-9]*$" then
          return
        end
        vim.fn.wildtrigger()
      end,
    })
  end

}
