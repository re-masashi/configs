
vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<Leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>t', ':vsplit | terminal<CR>', { noremap = true, silent = true })
