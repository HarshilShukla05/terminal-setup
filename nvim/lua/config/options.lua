-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.laststatus = 3
vim.opt.cmdheight = 0
vim.opt.showmode = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 8
vim.opt.pumblend = 0
vim.opt.winblend = 0
-- Rounded corners on every float that doesn't pass a border of its own — LSP
-- hover, diagnostics, snacks input, completion docs. Telescope, which-key and
-- lualine already round themselves, so this is the whole remaining gap.
vim.opt.winborder = "rounded"
vim.opt.fillchars = {
  eob = " ",
  fold = " ",
  foldopen = "",
  foldclose = "",
  foldsep = " ",
  diff = "╱",
}
