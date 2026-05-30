-- nvim-navic — LSP-powered code-position breadcrumb for the statusline.
-- e.g. `exports → generateSignedMediaUrl → if signedUrlFromCache`.
-- Auto-attaches to any LSP that supports `textDocument/documentSymbol`.
-- Consumed by lualine (see plugins/ui.lua, lualine_c section).
return {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = function()
    vim.g.navic_silence = true
  end,
  opts = {
    separator = "  ",       -- arrow between breadcrumb segments
    highlight = true,
    depth_limit = 5,
    lsp = { auto_attach = true },
  },
}
