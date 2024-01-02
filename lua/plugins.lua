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
return require("lazy").setup({
  { "MirekNguyen/czech-diacritics.nvim", config = true, cmd = "AddDiacritics" },
  {
    "uga-rosa/translate.nvim",
    config = {
      default = {
        command = "google",
        output = "replace",
      },
    },
    cmd = "Translate"
  },
  {
		"ellisonleao/gruvbox.nvim",
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
		lazy = false,
	},
	{
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("plugins.nvim-tree")
		end,
		cmd = { "NvimTreeToggle" },
	},
	{
		"romgrk/barbar.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.barbar")
		end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					fzf = {
						fuzzy = true, -- false will only do exact matching
						override_generic_sorter = true, -- override the generic sorter
						override_file_sorter = true, -- override the file sorter
						case_mode = "smart_case", -- or "ignore_case" or "respect_case"
						-- the default case_mode is "smart_case"
					},
					telescope_path = {
						search_dir = "$HOME",
						ignore_file = "$HOME/.config/dotfiles/config/fdignore",
					},
				},
			})
			require("telescope").load_extension("telescope_path")
			require("telescope").load_extension("fzf")
		end,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mireknguyen/telescope-path.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.treesitter")
		end,
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "Mason", "LspInstall", "LspUninstall", "LspInfo" },
		config = function()
			require("plugins.lsp")
		end,
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
				config = true,
				opts = { automatic_installation = true },
				dependencies = {
					"williamboman/mason.nvim",
					config = true,
				},
			},
		},
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		config = function()
			require("plugins.lsp-cmp")
		end,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				config = function()
					require("plugins.luasnip")
				end,
			},
			{ "onsails/lspkind.nvim" },
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"saadparwaiz1/cmp_luasnip",
		},
	},
	{
		"nvimtools/none-ls.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("plugins.null-ls")
		end,
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},
				lightbulb = {
					sign = false,
				},
			})
		end,
	},
	{ "mbbill/undotree", cmd = "UndotreeToggle" },
	{ "lewis6991/gitsigns.nvim", opts = { signcolumn = false }, cmd = "Gitsigns" },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    config = function()
      require("chatgpt").setup({
        chat = {
          openai_params = {
            model = "gpt-3.5-turbo",
            max_tokens = 4096,
          },
          openai_edit_params = {
            model = "gpt-3.5-turbo",
          },
          keymaps = {
            select_session = "o",
          }
        }
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  {
    "folke/zen-mode.nvim",
    config = {
      window = {
        width = .5
      }
    },
    cmd = "ZenMode"
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = {
      panel = {
        enabled = true,
        auto_refresh = true, -- auto refresh panel
        layout = {
          position = "right", -- | top | left | right
          ratio = 0.4 -- width of the panel, when position is left or right
        },
      },
      suggestion = {
        enabled = true, -- enable suggestions
        auto_trigger = true, -- automatically show suggestions
        accept = false, -- disable built-in keymapping
        keymap = {
          accept = "<C-f>",
          next = "<C-;>",
          prev = "<C-'>",
          dismiss = '<C-\\>',
        }
      }
    }
  },
}, {
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip", -- edit zip files
				-- "matchit", -- match XML tags using '%'
				-- "matchparen", -- highlight matching brackets
				-- "netrwPlugin",
				"tarPlugin", -- edit tar files
				"tohtml",
				"tutor",
				"zipPlugin",
				"rplugin", -- remote plugins
				"spellfile",
				"man", -- ':Man' command (man pages)
				"shada", -- search, command history, marks
				"health", -- ':checkhealth' command
			},
		},
	},
	defaults = { lazy = true },
})
