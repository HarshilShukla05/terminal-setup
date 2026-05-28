return {
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        prompt_prefix = "  ",
        selection_caret = " ",
        path_display = { "truncate" },
        layout_config = {
          width = 0.92,
          height = 0.88,
          prompt_position = "bottom",
          preview_cutoff = 120,
          horizontal = {
            preview_width = 0.58,
            results_width = 0.42,
          },
          vertical = {
            mirror = false,
          },
        },
      })

      opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
        buffers = {
          sort_mru = true,
          sort_lastused = true,
          theme = "dropdown",
          previewer = false,
          initial_mode = "normal",
        },
        oldfiles = {
          only_cwd = false,
        },
        live_grep = {
          additional_args = function()
            return { "--hidden" }
          end,
        },
        current_buffer_fuzzy_find = {
          theme = "dropdown",
          previewer = false,
        },
        lsp_references = {
          show_line = false,
        },
        lsp_definitions = {
          show_line = false,
        },
        lsp_implementations = {
          show_line = false,
        },
        lsp_type_definitions = {
          show_line = false,
        },
      })

      return opts
    end,
  },
}
