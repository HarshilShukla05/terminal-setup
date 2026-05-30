-- Disable ts_ls so only vtsls handles JS/TS. Both were auto-attaching to every
-- JS/TS buffer, so "go to definition" returned the same location twice (and
-- ts_ls also threw "No Project" without a tsconfig).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ts_ls = { enabled = false },
      },
    },
  },
}
