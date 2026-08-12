-- Supermaven — AI inline (ghost-text) completion.
-- Coexists with blink.cmp: blink owns <Tab> (LSP/snippet menu), Supermaven uses
-- its own dedicated keys so they never fight.
--   <M-l> (Option+L) → accept the full ghost-text suggestion
--   <M-;>            → accept just the next word
--   <C-]>            → dismiss the current suggestion
-- Toggle the whole thing on/off anytime with <leader>cm.
-- (Avoids <C-j> on purpose — that's the tmux prefix and never reaches nvim.)
--
-- Disabled entirely under the leetcode.nvim storage dir (`condition` below) —
-- practice should be your own recall, not AI-completed. blink.cmp keeps
-- working there for plain LSP/snippet completion (function/variable names,
-- <Tab> to select).
local leetcode_dir = vim.fn.stdpath("data") .. "/leetcode"

return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  cmd = {
    "SupermavenToggle",
    "SupermavenStart",
    "SupermavenStop",
    "SupermavenStatus",
    "SupermavenUseFree",
    "SupermavenUsePro",
  },
  keys = {
    { "<leader>cm", "<cmd>SupermavenToggle<cr>", desc = "Toggle Supermaven (AI completion)" },
  },
  opts = {
    keymaps = {
      accept_suggestion = "<M-l>",
      accept_word       = "<M-;>",
      clear_suggestions = "<C-]>",
    },
    -- Don't suggest in noisy/secret filetypes.
    ignore_filetypes = { gitcommit = true, gitrebase = true },
    disable_inline_completion = false, -- we WANT inline ghost text
    disable_keymaps = false,
    -- Re-checked on every BufEnter; true stops Supermaven for that buffer.
    condition = function()
      local path = vim.api.nvim_buf_get_name(0)
      return path:sub(1, #leetcode_dir) == leetcode_dir
    end,
  },
  config = function(_, opts)
    require("supermaven-nvim").setup(opts)
  end,
}
