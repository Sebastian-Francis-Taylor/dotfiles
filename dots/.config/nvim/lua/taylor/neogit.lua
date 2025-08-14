local neogit = require('neogit')
vim.keymap.set('n', '<leader>vg', ':Neogit<cr>', {silent = true, noremap = true})
neogit.setup {}
