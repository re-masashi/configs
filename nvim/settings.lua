-- Enable line numbers
vim.wo.number = true

-- Enable relative line numbers
vim.wo.relativenumber = true

-- Enable cursor line
vim.wo.cursorline = true

-- Enable syntax highlighting
vim.cmd([[syntax on]])

-- Set the leader key to space
vim.g.mapleader = " "

-- Set the tab size to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Set the font size
vim.opt.guifont = "Monaco:h14"

-- Set the background color
vim.opt.background = "dark"

-- Set the mouse mode
vim.opt.mouse = "a"

-- Set the clipboard
vim.opt.clipboard = "unnamedplus"
