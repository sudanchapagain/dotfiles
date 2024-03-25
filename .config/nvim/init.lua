-- TEMPORARY. To force learn hjkl movement.
-- vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", { noremap = true, silent = true })

-- force learn C-b & C-f to move cursor in insert mode or use normal mode
-- vim.api.nvim_set_keymap("i", "<Left>", "<Nop>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<Right>", "<Nop>", { noremap = true, silent = true })

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

-- Fold if not folded, unfold if folded.
vim.keymap.set("n", "zz", function()
	local current_line_number, col = unpack(vim.api.nvim_win_get_cursor(0))
	local is_line_folded = vim.fn.foldclosed(current_line_number)
	if is_line_folded > 0 then
		vim.api.nvim_feedkeys("zd", "n", true)
	else
		local current_line = vim.api.nvim_get_current_line()
		local curly = "{}"
		local round = "()"
		local square = "[]"
		local triangle = "<>"
		local brackets = {}
		local is_start_last = {}
		brackets[curly] = 0
		brackets[round] = 0
		brackets[square] = 0
		brackets[triangle] = 0
		is_start_last[curly] = nil
		is_start_last[round] = nil
		is_start_last[square] = nil
		is_start_last[triangle] = nil
		for i = 1, #current_line do
			local c = current_line:sub(i, i)
			if c == "{" then
				brackets[curly] = brackets[curly] + 1
				is_start_last[curly] = true
			end
			if c == "}" then
				brackets[curly] = brackets[curly] - 1
				is_start_last[curly] = false
			end
			if c == "(" then
				brackets[round] = brackets[round] + 1
				is_start_last[round] = true
			end
			if c == ")" then
				brackets[round] = brackets[round] - 1
				is_start_last[round] = false
			end
			if c == "[" then
				brackets[square] = brackets[square] + 1
				is_start_last[square] = true
			end
			if c == "]" then
				brackets[square] = brackets[square] - 1
				is_start_last[square] = false
			end
			if c == "<" then
				brackets[triangle] = brackets[triangle] + 1
				is_start_last[triangle] = true
			end
			if c == ">" then
				brackets[triangle] = brackets[triangle] - 1
				is_start_last[triangle] = false
			end
		end
		if brackets[curly] ~= 0 then
			-- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
			if is_start_last[curly] then
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F{", "n", true)
				end, 0)
			else
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F}", "n", true)
				end, 0)
			end
			vim.defer_fn(function()
				vim.api.nvim_feedkeys("zf%", "n", true)
			end, 10)
		elseif brackets[round] ~= 0 then
			-- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
			if is_start_last[round] then
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F(", "n", true)
				end, 0)
			else
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F)", "n", true)
				end, 0)
			end
			vim.defer_fn(function()
				vim.api.nvim_feedkeys("zf%", "n", true)
			end, 10)
		elseif brackets[square] ~= 0 then
			-- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
			if is_start_last[square] then
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F[", "n", true)
				end, 0)
			else
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F]", "n", true)
				end, 0)
			end
			vim.defer_fn(function()
				vim.api.nvim_feedkeys("zf%", "n", true)
			end, 10)
		elseif brackets[triangle] ~= 0 then
			-- `nvim_feedkeys` does not wait for commands to complete, so I added a delay manually
			if is_start_last[triangle] then
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F<", "n", true)
				end, 0)
			else
				vim.defer_fn(function()
					vim.api.nvim_feedkeys("$F>", "n", true)
				end, 0)
			end
			vim.defer_fn(function()
				vim.api.nvim_feedkeys("zf%", "n", true)
			end, 10)
		else
			local prompt = vim.fn.input("Do you want to colapse this whole paragraph? [y/N]")
			local yes_options = {
				["y"] = true,
				["Y"] = true,
			}
			if yes_options[prompt] then
				vim.api.nvim_feedkeys("vapkzf", "n", true)
			end
			vim.cmd("echo ''")
		end
	end
end)

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
	"ThePrimeagen/vim-be-good",
	"nvim-lua/plenary.nvim",
	"github/copilot.vim",
	"mbbill/undotree",

	{
		"LintaoAmons/easy-commands.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			local custom_auto = require("lualine.themes.auto")
			custom_auto.normal.c.bg = "NONE"
			vim.cmd("colorscheme rose-pine")
		end,
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
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.golines,
					null_ls.builtins.formatting.latexindent,
					null_ls.builtins.formatting.fixjson,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.nixpkgs_fmt,
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

	--                TROUBLE
	------------------------------------------------
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		config = function()
			vim.keymap.set("n", "B", function()
				require("trouble").toggle()
			end)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "│" },
					change = { text = "│" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false,
				linehl = false,
				word_diff = false,
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol",
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil,
				max_file_length = 40000,
				preview_config = {
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				yadm = {
					enable = false,
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

	--                Indent Blankline
	------------------------------------------------
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = {
					char = "│",
					tab_char = "│",
				},
				whitespace = {
					remove_blankline_trail = false,
				},
				scope = { enabled = false },
				exclude = {
					filetypes = {
						"help",
						"dashboard",
						"Trouble",
						"trouble",
						"lazy",
						"mason",
						"toggleterm",
						"lazyterm",
					},
				},
			})
		end,
	},

	--                Indent Animation
	------------------------------------------------
	{
		"echasnovski/mini.indentscope",
		version = "*",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"dashboard",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
		config = function()
			require("mini.indentscope").setup()
		end,
	},
})
