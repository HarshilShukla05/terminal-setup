-- UI: clean Kanagawa look — minimal lualine, plain bufferline, snacks dashboard.

return {
  -- ─── Snacks: dashboard disabled (open straight into an empty buffer) ─
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = { enabled = false }
      return opts
    end,
  },

  -- ─── Bufferline (clean: no slant, just tabs) ─────────────────────────
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        always_show_bufferline = true,
        separator_style = "thin",
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator = { style = "underline" },
        modified_icon = "●",
      })
      return opts
    end,
  },

  -- ─── Lualine (minimal Kanagawa, big & clean) ─────────────────────────
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "kanagawa",
        globalstatus = true,
        component_separators = "",
        section_separators = { left = "", right = "" },
      })

      opts.sections = {
        lualine_a = { { "mode" } },
        lualine_b = {
          { "branch", icon = "" },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local g = vim.b.gitsigns_status_dict
              if g then
                return { added = g.added, modified = g.changed, removed = g.removed }
              end
            end,
          },
        },
        lualine_c = {
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn  = icons.diagnostics.Warn,
              info  = icons.diagnostics.Info,
              hint  = icons.diagnostics.Hint,
            },
          },
        },
        lualine_y = { { "progress" } },
        lualine_z = { { "location" } },
      }

      return opts
    end,
  },

  -- ─── which-key (modern, rounded, snappy) ─────────────────────────────
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.preset = "modern"
      opts.delay = function(ctx) return ctx.plugin and 0 or 200 end
      opts.win = vim.tbl_deep_extend("force", opts.win or {}, {
        border = "rounded",
        padding = { 1, 2 },
        title = false,
      })
      opts.layout = vim.tbl_deep_extend("force", opts.layout or {}, {
        width = { min = 24 },
        spacing = 4,
      })
      return opts
    end,
  },
}
