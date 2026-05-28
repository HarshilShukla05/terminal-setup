return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        compile = false,
        undercurl = true,
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,
        dimInactive = false,
        terminalColors = true,
        theme = "dragon",
        background = { dark = "dragon", light = "lotus" },
        colors = {
          theme = {
            all = {
              ui = {
                bg_gutter = "none",
                float = {
                  bg = "#0d0c0c",
                  bg_border = "#393836",
                },
              },
            },
          },
        },
        overrides = function(colors)
          local theme = colors.theme
          local palette = colors.palette
          return {
            CursorLine = { bg = theme.ui.bg_p1 },
            CursorLineNr = { fg = palette.carpYellow, bold = true },
            WinSeparator = { fg = theme.ui.bg_m3, bg = "NONE" },
            NormalFloat = { bg = theme.ui.bg_m3 },
            FloatBorder = { fg = palette.waveBlue2, bg = theme.ui.bg_m3 },
            FloatTitle = { fg = palette.springBlue, bg = theme.ui.bg_m3, bold = true },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            Pmenu = { fg = theme.ui.fg, bg = theme.ui.bg_m1 },
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2, bold = true },
            PmenuSbar = { bg = theme.ui.bg_m2 },
            PmenuThumb = { bg = theme.ui.special },
            Visual = { bg = theme.ui.bg_search },
            Search = { fg = theme.ui.fg, bg = theme.ui.bg_search },
            IncSearch = { fg = theme.ui.bg_m3, bg = palette.carpYellow },
            MatchParen = { fg = palette.springBlue, bg = theme.ui.bg_p2, bold = true },
            StatusLine = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
            StatusLineNC = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            TabLineFill = { bg = theme.ui.bg_m3 },
            DiagnosticVirtualTextError = { fg = theme.diag.error, bg = theme.ui.bg_m1 },
            DiagnosticVirtualTextWarn = { fg = theme.diag.warning, bg = theme.ui.bg_m1 },
            DiagnosticVirtualTextInfo = { fg = theme.diag.info, bg = theme.ui.bg_m1 },
            DiagnosticVirtualTextHint = { fg = theme.diag.hint, bg = theme.ui.bg_m1 },
          }
        end,
      }
    end,
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd.colorscheme("kanagawa-dragon")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "kanagawa-dragon" },
  },
}
