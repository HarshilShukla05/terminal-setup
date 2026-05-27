local function repo_root()
  local cwd = vim.fn.expand("%:p:h")
  if cwd == "" then
    cwd = vim.uv.cwd()
  end
  local root = vim.fs.root(cwd, ".git")
  return root or cwd
end

local function upstream_ref()
  local root = repo_root()
  local upstream = vim.fn.systemlist({
    "git",
    "-C",
    root,
    "rev-parse",
    "--abbrev-ref",
    "--symbolic-full-name",
    "@{upstream}",
  })[1]

  if vim.v.shell_error == 0 and upstream and upstream ~= "" then
    return upstream
  end

  local origin_head = vim.fn.systemlist({
    "git",
    "-C",
    root,
    "symbolic-ref",
    "refs/remotes/origin/HEAD",
    "--short",
  })[1]

  if vim.v.shell_error == 0 and origin_head and origin_head ~= "" then
    return origin_head
  end

  return "origin/main"
end

return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Repo Diff" },
      {
        "<leader>gD",
        function()
          vim.cmd("DiffviewOpen " .. upstream_ref() .. "...HEAD")
        end,
        desc = "Branch Diff",
      },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Current File History" },
      { "<leader>gl", "<cmd>DiffviewFileHistory<cr>", desc = "Repo History" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree",
        win_config = {
          position = "left",
          width = 38,
        },
      },
      keymaps = {
        view = {
          { "n", "<leader>e", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle File Panel" } },
        },
        file_panel = {
          { "n", "<leader>e", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle File Panel" } },
        },
      },
    },
  },
}
