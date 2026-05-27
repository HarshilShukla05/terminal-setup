return {
  {
    "folke/snacks.nvim",
    opts = function(_, opts)
      opts.dashboard = {
        preset = {
          pick = function(cmd, picker_opts)
            return LazyVim.pick(cmd, picker_opts)()
          end,
          header = [[
██╗  ██╗ █████╗ ███╗   ██╗ █████╗  ██████╗  █████╗ ██╗    ██╗ █████╗
██║ ██╔╝██╔══██╗████╗  ██║██╔══██╗██╔════╝ ██╔══██╗██║    ██║██╔══██╗
█████╔╝ ███████║██╔██╗ ██║███████║██║  ███╗███████║██║ █╗ ██║███████║
██╔═██╗ ██╔══██║██║╚██╗██║██╔══██║██║   ██║██╔══██║██║███╗██║██╔══██║
██║  ██╗██║  ██║██║ ╚████║██║  ██║╚██████╔╝██║  ██║╚███╔███╔╝██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═╝
          ]],
          keys = {
            { icon = " ", key = "f", desc = "Find Files", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Live Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "p", desc = "Projects", action = ":Telescope projects" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1, limit = 8 },
          { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1, limit = 8 },
          { section = "startup" },
        },
      }

      return opts
    end,
  },

  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        always_show_bufferline = true,
        separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
        indicator = { style = "underline" },
        modified_icon = "●",
        diagnostics_indicator = function(_, _, diag)
          local ret = {}
          if diag.error and diag.error > 0 then
            table.insert(ret, icons.diagnostics.Error .. diag.error)
          end
          if diag.warning and diag.warning > 0 then
            table.insert(ret, icons.diagnostics.Warn .. diag.warning)
          end
          return table.concat(ret, " ")
        end,
        offsets = {
          {
            filetype = "snacks_layout_box",
            text = "Explorer",
            highlight = "Directory",
            text_align = "left",
          },
        },
      })

      return opts
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local icons = LazyVim.config.icons

      local function repo_name()
        local buf = vim.api.nvim_get_current_buf()
        local cached = vim.b[buf].repo_name_cache
        if cached ~= nil then
          return cached
        end
        local path = vim.api.nvim_buf_get_name(buf)
        local dir = path ~= "" and vim.fn.fnamemodify(path, ":h") or vim.fn.getcwd()
        local found = vim.fs.find(".git", { path = dir, upward = true })[1]
        local name = found and vim.fn.fnamemodify(vim.fs.dirname(found), ":t") or ""
        vim.b[buf].repo_name_cache = name
        return name
      end

      opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
        theme = "kanagawa",
        globalstatus = true,
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
      })

      opts.sections = {
        lualine_a = {
          { "mode", separator = { left = "", right = "" }, right_padding = 1 },
        },
        lualine_b = {
          {
            repo_name,
            icon = "",
            cond = function()
              return repo_name() ~= ""
            end,
          },
          { "branch", icon = "" },
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {
          LazyVim.lualine.root_dir(),
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Statement") }
            end,
          },
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Constant") }
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
        },
        lualine_y = {
          { "progress", separator = " ", padding = { left = 1, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          {
            function()
              return " " .. os.date("%R")
            end,
            separator = { left = "", right = "" },
          },
        },
      }

      return opts
    end,
  },

  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.preset = "modern"
      opts.delay = function(ctx)
        return ctx.plugin and 0 or 200
      end
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
