require "nvchad.autocmds"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Remember cursor position when reopening files (improved version)
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("restore_cursor", { clear = true }),
  pattern = "*",
  callback = function()
    local line = vim.fn.line "'\""
    if
      line > 1
      and line <= vim.fn.line "$"
      and vim.bo.filetype ~= "commit"
      and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
    then
      vim.cmd 'normal! g`"'
    end
  end,
})

-- Auto reload file when changed externally
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("auto_reload", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

-- Notification after reloading
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = vim.api.nvim_create_augroup("reload_notify", { clear = true }),
  pattern = "*",
  callback = function()
    vim.notify("File changed on disk. Buffer reloaded.", vim.log.levels.WARN)
  end,
})

-- Dynamic terminal padding (Kitty)
local term = os.getenv("TERM_PROGRAM")
if term == "kitty" then
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("kitty_padding", { clear = true }),
    callback = function()
      vim.fn.system("kitty @ set-spacing padding=0 margin=0 2>/dev/null")
    end,
  })

  vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("kitty_padding_restore", { clear = true }),
    callback = function()
      vim.fn.system("kitty @ set-spacing padding=20 margin=10 2>/dev/null")
    end,
  })
end
