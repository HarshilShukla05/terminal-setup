-- Autocmds loaded on VeryLazy (which fires AFTER VimEnter, so a VimEnter
-- autocmd here would never run — we just do the check directly).

-- On `nvim` with no file argument, pop the Telescope file picker.
-- Pick a file -> opens it. <Esc> -> drops you in an empty buffer.
if vim.fn.argc() == 0 then
  vim.schedule(function()
    local ok, builtin = pcall(require, "telescope.builtin")
    if ok then
      builtin.find_files()
    end
  end)
end
