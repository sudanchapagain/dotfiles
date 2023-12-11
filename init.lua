-- VIM
-- Set the global leader key
vim.g.mapleader = ' '
-- Set the local leader key
vim.g.maplocalleader = ' '

-- EDITOR
-- line numbers in the gutter.
vim.opt.number = true
-- relative line numbers.
vim.opt.relativenumber = false
-- line wrapping.
vim.opt.wrap = true
vim.opt.linebreak = true
-- the number of spaces a tab character counts for.
vim.opt.tabstop = 2
-- the number of spaces for a "soft" tabstop.
vim.opt.softtabstop = 2
-- the number of spaces used for each level of (auto)indentation.
vim.opt.shiftwidth = 2
-- expanding tabs into spaces. Tab key inserts spaces instead of a tab character.
vim.opt.expandtab = true
-- rounding the indentation to a multiple of 'shiftwidth'.
vim.opt.shiftround = true
-- smart auto-indenting.
vim.opt.smartindent = true

-- MORE EDITOR
-- incremental searching. As you type a search pattern highlights the matching text in real-time.
vim.opt.incsearch = true
-- sets the default file format to Windows (CRLF) line endings.
vim.opt.fileformat = 'dos'
-- true color support for the terminal.
vim.opt.termguicolors = true
-- mouse support in all modes, 'a' for 'all'.
vim.opt.mouse = 'a'
-- Highlight search results as you type for specific file types
vim.cmd([[autocmd FileType markdown,text setlocal spell]])
-- Display line endings in the status line using the Airline plugin
vim.g.airline_section_z = '%{&fileformat}'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'


-- LAZY.NVIM Package Manager
-- Check if lazy is installed if not git clone it.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
-- adds lazy into neovim environment runtime.
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "folke/which-key.nvim",
  "nvim-lua/plenary.nvim",
  -- theme
  {
    "sainnhe/sonokai",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'sonokai'
    end,
  },
  -- Git integration
  "tpope/vim-fugitive",
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

    -- Fuzzy Finder (files, lsp, etc)
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          -- NOTE: If you are having trouble with this installation,
          --       refer to the README for telescope-fzf-native for more instructions.
          build = 'make',
          cond = function()
            return vim.fn.executable 'make' == 1
          end,
        },
      },
    },

    {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
    },
  
})

-- Treesitter setup

require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
  require = {'nvim-lua/plenary.nvim'}, 
}

-- Mason setup
require("mason").setup{}


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

