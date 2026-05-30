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
            -- Thin visible separator between nvim splits (dragon overlay tone).
            WinSeparator = { fg = "#393836", bg = "NONE" },
            -- Transparent floats (kanagawa.nvim README recipe): floats blend
            -- with the editor bg instead of showing as a separate darker box.
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle  = { bg = "none" },

            -- Telescope: same Dragon-green accent for all 3 boxes — titles as
            -- filled chips (dark text on green) and the box borders in green.
            TelescopeResultsTitle  = { fg = "#181616", bg = "#87a987", bold = true },
            TelescopePreviewTitle  = { fg = "#181616", bg = "#87a987", bold = true },
            TelescopePromptTitle   = { fg = "#181616", bg = "#87a987", bold = true },
            TelescopeBorder        = { fg = "#87a987" },
            TelescopeResultsBorder = { fg = "#87a987" },
            TelescopePreviewBorder = { fg = "#87a987" },
            TelescopePromptBorder  = { fg = "#87a987" },
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
