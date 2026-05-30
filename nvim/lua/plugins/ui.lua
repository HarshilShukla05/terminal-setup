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

  -- ─── Bufferline disabled (no tab bar at top — more editor space) ────
  -- Buffer navigation still works via Harpoon (<leader>a/<M-1..4>),
  -- Telescope buffers (<leader>,), and :bnext/:bprev.
  { "akinsho/bufferline.nvim", enabled = false },

  -- ─── Lualine (kanagawa README look: rounded sections, compact mode) ──
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "kanagawa",
        globalstatus = true,
        -- thin vertical between components inside a section, rounded edges
        -- between sections (powerline half-circles, Nerd Font required).
        component_separators = { left = "\u{2502}", right = "\u{2502}" }, -- │ thin vertical
        section_separators   = { left = "\u{e0b6}", right = "\u{e0b4}" }, -- powerline rounded half-circles
      })

      -- LSP indicator: "[LSP] JS" / "[LSP] RUST" / etc. — compact, matches
      -- the kanagawa README look (single tag + uppercase language).
      local lang_short = {
        javascript = "JS",  typescript = "TS",
        javascriptreact = "JSX", typescriptreact = "TSX",
        python = "PY", markdown = "MD",
      }
      local function lsp_status()
        if #vim.lsp.get_clients({ bufnr = 0 }) == 0 then return "" end
        local ft = vim.bo.filetype
        return "[LSP] " .. (lang_short[ft] or ft:upper())
      end

      -- Repo name = the dir holding the nearest .git (cached per-buffer).
      local function repo_name()
        local buf = vim.api.nvim_get_current_buf()
        local cached = vim.b[buf].repo_name_cache
        if cached ~= nil then return cached end
        local path = vim.api.nvim_buf_get_name(buf)
        local dir  = (path ~= "" and vim.fn.fnamemodify(path, ":h")) or vim.fn.getcwd()
        local found = vim.fs.find(".git", { path = dir, upward = true })[1]
        local name = found and vim.fn.fnamemodify(vim.fs.dirname(found), ":t") or ""
        vim.b[buf].repo_name_cache = name
        return name
      end

      opts.sections = {
        -- "N" / "I" / "V" / "C" — single letter for compactness like reference
        lualine_a = {
          { "mode", fmt = function(str) return str:sub(1, 1) end },
        },
        lualine_b = {
          {
            repo_name,
            icon = "",
            cond = function() return repo_name() ~= "" end,
          },
          { "branch", icon = "" },
          {
            "diff",
            symbols = {
              added    = icons.git.added,
              modified = icons.git.modified,
              removed  = icons.git.removed,
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
          -- LSP-powered breadcrumb: shows where the cursor is in the code structure
          {
            function() return require("nvim-navic").get_location() end,
            cond = function()
              local ok, navic = pcall(require, "nvim-navic")
              return ok and navic.is_available()
            end,
          },
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
          { lsp_status, icon = "" },
        },
        lualine_y = { { "location" } },
        lualine_z = { { "progress" } },
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
