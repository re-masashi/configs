local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- Mason for managing LSPs, linters, and formatters
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
    
  {'akinsho/toggleterm.nvim', version = "*", config = true},

  -- Autocomplete
  { 'neovim/nvim-lsp-installer' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-vsnip' },
  { 'hrsh7th/cmp-nvim-lua' },
  { 'onsails/lspkind-nvim' },

  -- Format on save (using Neoformat)
  { 'sbdchd/neoformat' },

  -- LSP support
  { 'williamboman/nvim-lsp-installer' },
  { 'neovim/nvim-lspconfig' },

  -- Optional: Additional LSP features
  { 'jose-elias-alves/null-ls.nvim' }, -- For code actions and diagnostics
  { 'glepnir/lspsaga.nvim' }, -- For LSP actions like code actions, rename, etc.

  -- Mason-lspconfig for integrating Mason with nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "ts_ls",
          "rust_analyzer",
          "gopls",
          "clangd",
          "html",
          "cssls",
          "lua_ls",
          "svelte",
        },
        automatic_installation = true,
      })
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
        },
      })
    end,
  },

  -- Treesitter for enhanced syntax highlighting and code parsing
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "lua",
          "python",
          "javascript",
          "typescript",
          "html",
          "css",
          "json",
          "yaml",
          "rust",
          "go",
          "svelte",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  -- nvim-cmp for autocompletion
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#expand"](args.body)
          end,
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-u>"] = cmp.mapping.scroll_docs(4),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- Lualine for status line
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = "|",
          section_separators = "",
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
      })
    end,
  },

  -- Telescope for fuzzy searching and file browsing
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })

      vim.api.nvim_set_keymap('n', ' ff', ':Telescope find_files<CR>', { noremap = true })
    end,
  },

  -- nvim-tree for file explorer
  {
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
      })
    end,
  },

  -- Additional plugins...

})

-- Set up cmp
vim.api.nvim_set_keymap('', '<C-x><C-o>', '<Cmd>:<C-u>call cmp#complete()<CR>', { noremap = true, silent = true })

-- Set up format on save (using Neoformat)
vim.cmd [[
  augroup FormatOnSave
    autocmd!
    autocmd BufWritePre *.{js,ts,jsx,tsx,vue,html,css,scss,less,json,graphql,yaml,md} :Neoformat
  augroup END
]]


-- Define LSP servers to use
local lsp_servers = {
  "lua_ls", 
  "pyright", 
  "ts_ls", 
  "rust_analyzer", 
  "gopls", 
}

-- Set up lspconfig
local capabilities = vim.lsp.with(vim.lsp.protocol.make_client_capabilities(), {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
      },
    },
  },
})

-- Use a loop to set up each LSP server
for _, lsp in ipairs(lsp_servers) do
  require('lspconfig')[lsp].setup({
    capabilities = capabilities,
  })
end
