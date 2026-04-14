-- sets universal clipboard
vim.keymap.set('v', '<leader>y', '"+y', {silent = true})
vim.keymap.set('v', '<leader>p', '"+p', {silent = true})
vim.keymap.set('n', '<leader>p', '"+p', {silent = true})
vim.keymap.set('n', '<leader>P', '"+P', {silent = true})
-- General keymaps
vim.keymap.set('n', '<leader>e', ':Explore<cr>', {silent = true})
vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>vu', '<cmd>Undotree<cr>')
-- Fra Victor
vim.keymap.set('n', '<leader>lb', function()
  vim.notify("Ligma Ballz")
end)


