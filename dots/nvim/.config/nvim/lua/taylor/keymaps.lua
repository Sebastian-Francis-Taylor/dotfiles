-- General settings
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.wo.scrolloff = 8
vim.opt.undofile = true -- long undo history
vim.opt.undodir = vim.fn.expand('~/.undo')
vim.opt.updatetime = 50 -- faster update time
vim.opt.guicursor = "n-v-i-c:block-Cursor" -- sets block cursor for all modes
-- for better tab spacing
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
-- sets universal clipboard
vim.keymap.set('v', '<leader>y', '"+y', {silent = true})
vim.keymap.set('v', '<leader>p', '"+p', {silent = true})
vim.keymap.set('n', '<leader>p', '"+p', {silent = true})
vim.keymap.set('n', '<leader>P', '"+P', {silent = true})
-- General keymaps
vim.keymap.set('n', '<leader>e', ':Explore<cr>', {silent = true})
-- Fra Victor
vim.keymap.set('n', '<leader>lb', function()
  vim.notify("Ligma Ballz")
end)


