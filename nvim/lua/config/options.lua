-- Options are automatically loaded before lazy.nvim startup.
if vim.fn.has("mac") == 0 then require("config.remote_clipboard").setup() end

vim.opt.relativenumber = false
