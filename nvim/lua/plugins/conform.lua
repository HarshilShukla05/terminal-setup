-- conform.nvim — format on save (Prime's setup, adapted for LazyVim)
-- Manual format: <leader>cf (LazyVim convention).
-- Format-on-save runs synchronously with LSP fallback if no formatter is set
-- for the filetype.
return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 5000 })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  opts = {
    format_on_save = {
      timeout_ms = 5000,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      yaml = { "prettier" },
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      markdown = { "prettier" },
      go = { "gofmt" },
      rust = { "rustfmt" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      elixir = { "mix" },
    },
    formatters = {
      ["clang-format"] = {
        prepend_args = { "-style=file", "-fallback-style=LLVM" },
      },
    },
  },
}
