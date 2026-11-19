local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

-- Reload files changed outside of Neovim
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank() end,
})

-- Keep splits equal when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. tab)
  end,
})

-- Reopen files at the last cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_position"),
  callback = function(event)
    if vim.bo[event.buf].filetype == "gitcommit" then return end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(event.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close utility windows with q
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = { "help", "man", "qf", "lspinfo", "checkhealth", "notify", "grug-far", "gitsigns-blame" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close" })
  end,
})

-- Wrap and spell-check prose
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("prose"),
  pattern = { "text", "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Create missing parent directories on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup("mkdir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    vim.fn.mkdir(vim.fn.fnamemodify(vim.uv.fs_realpath(event.match) or event.match, ":p:h"), "p")
  end,
})

-- switch-theme.sh sends SIGUSR1: re-apply the colours and statusline of the new theme
vim.api.nvim_create_autocmd("Signal", {
  group = augroup("theme_reload"),
  pattern = "SIGUSR1",
  callback = function()
    for _, name in ipairs({ "config.palette", "plugins.colorscheme", "plugins.ui" }) do
      package.loaded[name] = nil
    end
    require("plugins.colorscheme").config()
    if package.loaded["lualine"] then
      for _, spec in ipairs(require("plugins.ui")) do
        if spec[1] == "nvim-lualine/lualine.nvim" then require("lualine").setup(spec.opts()) end
      end
    end
  end,
})
