-- Autocmds loaded on VeryLazy (which fires AFTER VimEnter, so a VimEnter
-- autocmd here would never run — we just do the check directly).

-- On `nvim` with no file argument, pick up where this directory was left off.
-- persistence.nvim keeps one session per cwd, and with one tmux session per
-- service that means every service reopens its own buffers. The file picker is
-- only a fallback for a directory with no saved session yet — landing in a
-- restored buffer instead of a picker means a grep (<leader>sg) can be run
-- straight away, without having to open some file first just to get out of it.
if vim.fn.argc() == 0 then
  vim.schedule(function()
    local ok, persistence = pcall(require, "persistence")
    if ok then
      pcall(persistence.load)
    end

    for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
      if buf.name ~= "" then
        return
      end
    end

    local telescope_ok, builtin = pcall(require, "telescope.builtin")
    if telescope_ok then
      builtin.find_files()
    end
  end)
end
