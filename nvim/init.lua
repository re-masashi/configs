-- very important. do not remove this. tells nvim to look in .config/nvim
package.path = vim.fn.stdpath("config") .. "/?.lua;" .. package.path

-- Load settings
require("settings")

-- Load plugins
require("plugins")

vim.cmd([[colorscheme catppuccin-mocha]])

-- Load keybinds
require("keybinds")

-- Load autoload
require("autoload")

-- Load after
require("after")
