-------------------------------------------------
--                     VIM
------------------------------------------------

-- Set the global leader key
vim.g.mapleader = ' '
-- Set the local leader key
vim.g.maplocalleader = ' '

------------------------------------------------
--                   EDITOR
------------------------------------------------

-- Line numbers in the gutter.
vim.opt.number = true
-- Relative line numbers.
vim.opt.relativenumber = true
-- Color Column
vim.opt.colorcolumn = "70"
-- Line wrapping.
vim.opt.wrap = true
vim.opt.linebreak = true
-- The number of spaces a tab character counts for.
vim.opt.tabstop = 2
-- The number of spaces for a "soft" tabstop.
vim.opt.softtabstop = 2
-- The number of spaces used for each level of (auto)indentation.
vim.opt.shiftwidth = 2
-- Expanding tabs into spaces. Tab key inserts spaces instead of a tab character.
vim.opt.expandtab = true
-- Rounding the indentation to a multiple of 'shiftwidth'.
vim.opt.shiftround = true
-- Smart auto-indenting.
vim.opt.smartindent = true
-- Incremental searching. As you type a search pattern highlights the matching text in real-time.
vim.opt.incsearch = true
-- Sets the default file format to Windows (CRLF) line endings.
vim.opt.fileformat = 'dos'
-- True color support for the terminal.
vim.opt.termguicolors = true
-- Mouse support in all modes, 'a' for 'all'.
vim.opt.mouse = 'a'
-- Highlight search results as you type for specific file types.
vim.cmd([[autocmd FileType markdown,text setlocal spell]])
-- See `:help 'clipboard'`.
vim.o.clipboard = 'unnamedplus'
-- Theme
vim.cmd.colorscheme 'habamax'

------------------------------------------------
--        LAZY PACKAGE MANAGER
------------------------------------------------

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

-- Adds lazy into neovim environment runtime.
vim.opt.rtp:prepend(lazypath)

-- PACKAGES
require("lazy").setup({
    -- Simple Packages
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/vim-be-good",
    -- LSP
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = function()
                    require("mason").setup {}
                end,
            },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim', opts = {} },
        },
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({})
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
        end
    },

    -- Autocompletion
    {
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

    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },
    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
                config = function()
                    local builtin = require('telescope.builtin')
                    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
                    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
                    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
                    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
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
        config = function()
            require("nvim-treesitter.configs").setup {
                highlight = {
                    enable = true,
                }
            }
        end

    },

})



require('Comment').setup()

-- Mason setup
