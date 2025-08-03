local overrides = require("configs.overrides")

return {

    -- --------------------
    -- ui stuff
    -- --------------------

    {
        "NvChad/NvChad",
        lazy = false,
        branch = "v2.5",
        import = "nvchad.plugins",
        config = function()
            require("options")
        end,
    },

    {
        "goolord/alpha-nvim",
        lazy = false;
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.theta").config)
        end,
    },

    -- --------------------
    -- motions
    -- --------------------
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        event = "VeryLazy",
        config = function()
            -- require('leap').create_default_mappings()
            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
            vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
            vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)")
            require("leap").opts.equivalence_classes = {
                " \t\r\n",
                "aäàáâãāăạảãắằẳẵặấầẩẫậ",
                "dḍđ",
                "eëéèêēẹẻẽếềểễệ",
                "gǧğ",
                "hḥḫ",
                "iïīíìîıỉĩị",
                "nñ",
                "oọóòỏõōôốồộổỗơởỡớờợ",
                "sṣšß",
                "tṭ",
                "uúûüűùủũụưựứừửữ",
                "zẓ",
            }
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {},
    },

    {
        "cbochs/portal.nvim",
        event = "VeryLazy",
    },

    -- --------------------
    -- obsidian stuff
    -- --------------------
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        event = "VeryLazy",
        ft = "markdown",
        dependencies = {
            "hrsh7th/nvim-cmp",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "blackwhite",
                    path = "~/Documents/obsidian/blackwhite",
                },
            },
            disable_frontmatter = true,
            ui = {
				enable = true, -- set to false to disable all additional syntax features
				update_debounce = 200, -- update delay after a text change (in milliseconds)
				max_file_length = 5000, -- disable UI features for files with more than this many lines
				-- Define how various check-boxes are displayed
				checkboxes = {
					-- -- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
					-- [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
					-- ["x"] = { char = "", hl_group = "ObsidianDone" },
					-- [">"] = { char = "", hl_group = "ObsidianRightArrow" },
					-- ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
					-- ["!"] = { char = "", hl_group = "ObsidianImportant" },
					-- ["I"] = { char = "💡", hl_group = "ObsidianImportant" },
					-- -- Replace the above with this if you don't have a patched font:
					-- -- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
					-- -- ["x"] = { char = "✔", hl_group = "ObsidianDone" },
					--
					-- -- You can also add more custom ones...
				},
				-- Use bullet marks for non-checkbox lists.
				bullets = { char = "•", hl_group = "ObsidianBullet" },
				external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				-- Replace the above with this if you don't have a patched font:
				-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
				reference_text = { hl_group = "ObsidianRefText" },
				highlight_text = { hl_group = "ObsidianHighlightText" },
				tags = { hl_group = "ObsidianTag" },
				block_ids = { hl_group = "ObsidianBlockID" },
				hl_groups = {
					-- -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
					-- ObsidianTodo = { bold = true, fg = "#f78c6c" },
					-- ObsidianDone = { bold = true, fg = "#89ddff" },
					-- ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
					-- ObsidianTilde = { bold = true, fg = "#ff5370" },
					-- ObsidianImportant = { bold = true, fg = "#d73128" },
					ObsidianBullet = { bold = true, fg = "#89ddff" },
					ObsidianRefText = { underline = true, fg = "#c792ea" },
					ObsidianExtLinkIcon = { fg = "#c792ea" },
					ObsidianTag = { italic = true, fg = "#89ddff" },
					ObsidianBlockID = { italic = true, fg = "#89ddff" },
                    ObsidianHighlightText = { bg = "#eed49f", fg = "#1E1E2E" },
				},
			},
        },
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({ keymaps = { visual = "ms", visual_line = "mS" } })
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        event = "VeryLazy",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = "cd app && yarn install",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
    },

	{
		"hedyhli/outline.nvim",
		event = "VeryLazy",
		config = function()
			require("outline").setup({
				-- Your setup opts here (leave empty to use defaults)
			})
		end,
	},

    {
        "chomosuke/typst-preview.nvim",
        dev = false,
        ft = "typst",
        opts = {
            dependencies_bin = {
                ["typst-preview"] = "tinymist",
                ["websocat"] = "websocat",
            },
        },
    },

    {
        "mrcjkb/rustaceanvim",
        version = "^5",
        lazy = false,
    },

    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        -- or if using mini.icons/mini.nvim
        -- dependencies = { "echasnovski/mini.icons" },
        opts = {
            files = {
                previewer = "bat",
            },
        },
        init = function ()
            require("fzf-lua")
        end,
        lazy = false,
    },

    -- {
    --     'glacambre/firenvim',
    --     build = ":call firenvim#install(0)",
    -- },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function ()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }

            require("ibl").setup(
                {
                    indent = {
                        highlight = highlight,
                    },

                    scope = {
                        highlight = highlight,
                    },
                }
            )
        end
    },

    -- --------------------
    -- default stuff
    -- --------------------
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    -- {
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     build = "make",
    --     config = function()
    --         require("telescope").setup()
    --         require("telescope").load_extension("fzf")
    --     end,
    -- },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        cmd = {
            "NvimTreeFocus",
        },
        opts = overrides.nvimtree,
    },

    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("lazygit")
        end,
    },

    -- --------------------
    -- virtual envs
    -- --------------------
    -- {
    --     "linux-cultist/venv-selector.nvim",
    --     dependencies = {
    --         "neovim/nvim-lspconfig",
    --         -- 'mfussenegger/nvim-dap',
    --         -- 'mfussenegger/nvim-dap-python', --optional
    --         {
    --             "nvim-telescope/telescope.nvim",
    --             branch = "0.1.x",
    --             dependencies = { "nvim-lua/plenary.nvim" },
    --         },
    --     },
    --     lazy = false,
    --     branch = "regexp", -- This is the regexp branch, use this for the new version
    --     config = function()
    --         require("venv-selector").setup()
    --     end,
    --     keys = {
    --         -- Keymap to open VenvSelector to pick a venv.
    --         { "<leader>vs", "<cmd>VenvSelect<cr>" },
    --         -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
    --         { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
    --     },
    -- },

    {
        "anurag3301/nvim-platformio.lua",
        dependencies = {
            { "akinsho/nvim-toggleterm.lua" },
            { "nvim-telescope/telescope.nvim" },
            { "nvim-lua/plenary.nvim" },
        },
        cmd = {
            "Pioinit",
            "Piorun",
            "Piocmd",
            "Piolib",
            "Piomon",
            "Piodebug",
        },
    },

    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI", enable_autosnippets = true },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require("nvchad.configs.luasnip")
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },
        opts = function()
            return require("configs.cmp")
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },

    {
        'wakatime/vim-wakatime',
        lazy = false,
    },

    ---@type LazySpec
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                "<leader>-",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                -- Open in the current working directory
                "<leader>cw",
                "<cmd>Yazi cwd<cr>",
                desc = "Open the file manager in nvim's working directory" ,
            },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                '<c-up>',
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        ---@type YaziConfig
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = '<f1>',
            },
        },
    },

    -- comment plugin
    {
        "numToStr/Comment.nvim",
    },
}
