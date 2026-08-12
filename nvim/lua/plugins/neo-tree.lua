-- File explorer: show dotfiles and gitignored files (e.g. .env) so they can
-- be browsed and edited. Without this, neo-tree hides both by default.
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
