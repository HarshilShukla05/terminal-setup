-- LeetCode inside Neovim. Launch with:  nvim leetcode.nvim
--
-- Kept deliberately plain — the plugin's defaults are good. It supplies its own
-- C++ imports (`// @leet imports` block), so do NOT add an `injector` here or
-- you get the include twice.
--
-- NOTE: LazyVim binds <leader>l to :Lazy, which shadows the <leader>l* prefix
-- below. That mapping is deleted in lua/config/keymaps.lua.
return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  lazy = false,
  priority = 50,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },

  opts = {
    arg = "leetcode.nvim",
    lang = "cpp",
    picker = { provider = "telescope" },
  },

  keys = {
    { "<leader>lm", "<cmd>Leet menu<cr>", desc = "LeetCode: [M]enu" },
    { "<leader>ld", "<cmd>Leet daily<cr>", desc = "LeetCode: [D]aily challenge" },
    { "<leader>ll", "<cmd>Leet list<cr>", desc = "LeetCode: [L]ist problems" },
    { "<leader>ln", "<cmd>Leet random<cr>", desc = "LeetCode: Ra[n]dom" },
    { "<leader>lr", "<cmd>Leet run<cr>", desc = "LeetCode: [R]un test cases" },
    { "<leader>ls", "<cmd>Leet submit<cr>", desc = "LeetCode: [S]ubmit" },
    { "<leader>lc", "<cmd>Leet console<cr>", desc = "LeetCode: [C]onsole" },
    { "<leader>li", "<cmd>Leet info<cr>", desc = "LeetCode: [I]nfo" },
    { "<leader>lh", "<cmd>Leet hints<cr>", desc = "LeetCode: [H]ints" },
    { "<leader>lt", "<cmd>Leet tabs<cr>", desc = "LeetCode: [T]abs (switch problems)" },
    { "<leader>ly", "<cmd>Leet yank<cr>", desc = "LeetCode: [Y]ank solution" },
    { "<leader>lo", "<cmd>Leet open<cr>", desc = "LeetCode: [O]pen in browser" },
    { "<leader>lL", "<cmd>Leet last_submit<cr>", desc = "LeetCode: Restore [L]ast submit" },
    { "<leader>lR", "<cmd>Leet reset<cr>", desc = "LeetCode: [R]eset to default snippet" },
    { "<leader>lD", "<cmd>Leet desc toggle<cr>", desc = "LeetCode: Toggle [D]escription" },
    { "<leader>lg", "<cmd>Leet lang<cr>", desc = "LeetCode: Change lan[g]uage" },
    { "<leader>lC", "<cmd>Leet cookie update<cr>", desc = "LeetCode: Update [C]ookie" },
    { "<leader>lU", "<cmd>Leet cache update<cr>", desc = "LeetCode: [U]pdate problem cache" },
  },
}
