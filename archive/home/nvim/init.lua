--                     VIM
------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--               EDITOR GENERAL
------------------------------------------------
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.fileencoding = "utf-8"
vim.opt.ignorecase = true
vim.opt.smartcase = true

--               EDITOR EXTRAS
------------------------------------------------
vim.opt.incsearch = true
vim.opt.fileformat = "dos"
vim.opt.termguicolors = true
vim.cmd("set t_Co=256")
vim.opt.mouse = ""
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.o.clipboard = "unnamedplus"
vim.cmd([[set clipboard+=unnamedplus]])

--                EDITOR UI
------------------------------------------------
vim.opt.cmdheight = 2
vim.opt.pumheight = 10
vim.opt.conceallevel = 0
vim.opt.signcolumn = "yes"
vim.cmd([[autocmd FileType markdown,text setlocal spell]])

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("hi! Normal guibg=NONE ctermbg=NONE")
    vim.cmd("hi! NonText guibg=NONE ctermbg=NONE")
  end,
})

--                Keymaps
-------------------------------------------------
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Select all from any mode.
vim.keymap.set({ "n", "v", "i" }, "<C-g>", "<C-c>ggVG")

-- Save file from any mode
vim.keymap.set({ "n", "v", "i" }, "<C-s>", ":w<CR>")

-- Move selected lines with alt arrows like in subl
vim.keymap.set("v", "<A-K>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-J>", ":m '>+1<CR>gv=gv")
vim.keymap.set("n", "<A-K>", ":m .-2<cr>==")
vim.keymap.set("n", "<A-J>", ":m .+1<cr>==")

-- Keymaps to move between splits
vim.keymap.set("n", "<C-H>", "<C-W>h")
vim.keymap.set("n", "<C-J>", "<C-W>j")
vim.keymap.set("n", "<C-K>", "<C-W>k")
vim.keymap.set("n", "<C-L>", "<C-W>l")

-- Resize splits
vim.keymap.set("n", "<S-J>", "<Cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-K>", "<Cmd>vertical resize +2<CR>")
vim.keymap.set("n", "<S-H>", "<Cmd>resize -2<CR>")
vim.keymap.set("n", "<S-L>", "<Cmd>resize +2<CR>")

-- Indent/Unindent selected text with Tab and Shift+Tab
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move left and right while in insert mode.
vim.keymap.set("i", "<C-b>", "<Left>")
vim.keymap.set("i", "<C-f>", "<Right>")

--        LAZY PACKAGE MANAGER
------------------------------------------------
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
vim.opt.rtp:prepend(lazypath)

--                PACKAGES
------------------------------------------------
require("lazy").setup({

	--                Simple Packages
	------------------------------------------------
	"nvim-lua/plenary.nvim",
	"mbbill/undotree",

	{
		"LintaoAmons/easy-commands.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"ThePrimeagen/harpoon",
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
			vim.keymap.set("n", "<leader>a", mark.add_file)
			vim.keymap.set("n", "<leader>z", mark.rm_file)
			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)
			vim.keymap.set("n", "<C-s>", function()
				ui.nav_next()
			end)
			vim.keymap.set("n", "<C-a>", function()
				ui.nav_prev()
			end)
		end,
	},

	--                Language Server
	------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "j-hui/fidget.nvim", opts = {} },
			{
				"williamboman/mason.nvim",
				lazy = false,
				config = function()
					local mason = require("mason")
					mason.setup({
						ui = {
							icons = {
								package_installed = "✓",
								package_pending = "➜",
								package_uninstalled = "✗",
							},
						},
					})
				end,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				config = function()
					require("mason").setup()
					require("mason-lspconfig").setup()
				end,
				opts = {
					auto_install = true,
					automatic_installation = true,
				},
			},
		},
		config = function()
			local on_attach = function(_, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				nmap("<leader>ca", vim.slp.buf.code_action, "[C]ode [Actions]")
				nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinitions")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local lspconfig = require("lspconfig")
			local servers = { "tsserver", "tailwindcss", "gopls", "html", "cssls", "clangd", "jsonls", "lua_ls" }

			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "ca", vim.lsp.buf.code_action, {})
		end,
	},

	--                NONE LS
	------------------------------------------------

	{
		"nvimtools/none-ls.nvim",
		config = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.prettierd,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			})
			vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
		end,
	},

	--                Autocompletion
	------------------------------------------------
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				dependencies = {
					"saadparwaiz1/cmp_luasnip",
					"rafamadriz/friendly-snippets",
				},
			},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
					completeopt = "menu, menuone, noinsert",
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},

	--                TELESCOPE
	------------------------------------------------
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = function()
					return vim.fn.executable("make") == 1
				end,
				config = function()
					local builtin = require("telescope.builtin")
					vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
					vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
					vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
					vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
					require("telescope").setup({
						defaults = {
							sorting_strategy = "ascending",
							layout_strategy = "horizontal",
							layout_config = {
								horizontal = {
									prompt_position = "top",
								},
							},
						},
					})
				end,
			},
		},
	},

	--                TREESITTER
	------------------------------------------------
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-context",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				auto_install = true,
				indent = { enable = true },
				ensure_installed = {
					"c",
				},
			})
		end,
	},

	--                Lualine
	------------------------------------------------
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("lualine").setup({
				options = {
					icons_enabled = true,
					theme = "rose-pine",
					component_separators = "|",
					section_separators = "",
				},
			})
		end,
	},
})
