return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI / Claude" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>",              desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>",         desc = "Focus Claude window" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>",     desc = "Resume last Claude session" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>",   desc = "Continue Claude session" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",         desc = "Send current buffer to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeSend<cr>",
        mode = "v",
        desc = "Send visual selection to Claude",
      },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file (from tree)",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>",    desc = "Accept Claude's diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",      desc = "Reject Claude's diff" },
    },
  },
}
