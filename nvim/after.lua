require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
		disabled_types = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})

require("toggleterm").setup{}

-- Key mappings for toggling terminals
local Terminal = require('toggleterm.terminal').Terminal

-- Create terminal instances
local term1 = Terminal:new({ cmd = "zsh", hidden = true })
local term2 = Terminal:new({ cmd = "zsh", hidden = true })
local term3 = Terminal:new({ cmd = "zsh", hidden = true })

-- Function to toggle terminals
function _G.toggle_term1()
  term1:toggle()
end

function _G.toggle_term2()
  term2:toggle()
end

function _G.toggle_term3()
  term3:toggle()
end

-- Set key mappings
vim.api.nvim_set_keymap("n", "<A-1>", "<cmd>lua toggle_term1()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-2>", "<cmd>lua toggle_term2()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<A-3>", "<cmd>lua toggle_term3()<CR>", { noremap = true, silent = true })
