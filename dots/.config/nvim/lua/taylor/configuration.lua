-- General settings
-- leader set in init.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.undofile = true -- long undo history
vim.opt.undodir = vim.fn.expand('~/.undo')
vim.opt.updatetime = 50 -- faster update time
vim.opt.guicursor = "n-v-i-c:block-Cursor" -- sets block cursor for all modes
-- for better tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.colorcolumn = "80"
