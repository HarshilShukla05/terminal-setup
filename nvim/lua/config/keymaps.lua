-- Keymaps loaded on VeryLazy (LazyVim default).
-- LazyVim's default keymaps are untouched. We layer only the Prime extras
-- the user explicitly wants:
--   - centered scroll & search (universal QoL)
--   - tmux-sessionizer on <C-f>
-- Harpoon and format-on-save live in their own plugin specs under lua/plugins/.

local map = vim.keymap.set

-- Centered scroll & search (Prime QoL)
map("n", "<C-d>", "<C-d>zz", { desc = "Half-page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half-page up (centered)" })
map("n", "n",     "nzzzv",   { desc = "Next match (centered, unfolded)" })
map("n", "N",     "Nzzzv",   { desc = "Prev match (centered, unfolded)" })
map("n", "J",     "mzJ`z",   { desc = "Join lines, keep cursor put" })

-- tmux-sessionizer: open Prime's fuzzy project picker in a new tmux window
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>",
    { desc = "tmux-sessionizer (project jump)" })
