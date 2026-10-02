-- OPTIONS

-- Put binaries installed by mason.nvim on $PATH.
-- This has to happen before lazy.nvim boots, otherwise LSP clients spawned during
-- startup resolve `cmd` against the system $PATH and fail with "not executable".
local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
if vim.env.PATH then
  vim.env.PATH = mason_bin .. ':' .. vim.env.PATH
else
  vim.env.PATH = mason_bin
end

vim.o.number = true -- Show line numbers in a column.
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- Sync clipboard between OS and Neovim.
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 20    -- Keep this many screen lines above/below the cursor.
vim.o.list = true       -- Show <tab> and trailing spaces.

vim.o.showmode = false

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true
