return require('packer').startup(
   {
        function(use)
            local isWindows = vim.loop.os_uname().version:match "Windows"
            -- Packer can manage itself
            use 'wbthomason/packer.nvim'
            use 'nvim-lua/popup.nvim'
            use 'nvim-lua/plenary.nvim'
            use {
                'sainnhe/everforest',
            }
            use 'sainnhe/gruvbox-material'
            use 'tpope/vim-surround'
            use 'tpope/vim-repeat'
            use 'andymass/vim-matchup'
            use 'moll/vim-bbye'
            --use 'aymericbeaumet/vim-symlink' -- So that fugitive will follow symlinks properly
            use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', config = require('core.neogit').setup}
            use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
            use 'ThePrimeagen/git-worktree.nvim'
            use {
                "folke/trouble.nvim",
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {}
                end
            }
            use 'tpope/vim-abolish'
            use {
                'numToStr/Comment.nvim',
                config = function()
                    require('Comment').setup()
                end
            }
            use 'godlygeek/tabular'
            use 'stevearc/vim-arduino'
            use {
              'romgrk/barbar.nvim',
              requires = {'kyazdani42/nvim-web-devicons'}
            }
            use {
                'lewis6991/gitsigns.nvim',
                requires = {
                    'nvim-lua/plenary.nvim'
                },
                config = function()
                    require("core.gitsigns").setup()
                end
            }
            use {
                "lukas-reineke/indent-blankline.nvim",
                config=require('core.indent-blankline').setup
            } -- Indicate indentation levels with lines
            use 'kyazdani42/nvim-web-devicons' -- for file icons
            -- use {
            --     'kyazdani42/nvim-tree.lua',
            --     requires = 'kyazdani42/nvim-web-devicons',
            --     config = function() end
            -- }
            use {
                's1n7ax/nvim-window-picker',
                tag = "1.*",
                config = function()
                    require'window-picker'.setup({
                        autoselect_one = true,
                        include_current = false,
                        filter_rules = {
                            -- filter using buffer options
                            bo = {
                                -- if the file type is one of following, the window will be ignored
                                filetype = { 'neo-tree', "neo-tree-popup", "notify", "quickfix" },

                                -- if the buffer type is one of following, the window will be ignored
                                buftype = { 'terminal' },
                            },
                        },
                        other_win_hl_color = '#e35e4f',
                    })
                end
            }
            use {
              "nvim-neo-tree/neo-tree.nvim",
                branch = "v2.x",
                requires = {
                  "nvim-lua/plenary.nvim",
                  "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                  "MunifTanjim/nui.nvim",
                  "s1n7ax/nvim-window-picker"
                },
                 config = require("core.neotree").setup()
              }
            use 'unblevable/quick-scope'
            use {
                'hoob3rt/lualine.nvim',
                requires = {'kyazdani42/nvim-web-devicons', opt = true, config = function ()
                end
            }
        }
        -- use {
        --     "folke/todo-comments.nvim",
        --     requires = {"nvim-lua/plenary.nvim", "sainnhe/gruvbox-material"},
        --         config = function()
        --             local hl = require("todo-comments.highlight")
        --             local highlight_win = hl.highlight_win
        --             hl.highlight_win = function(win, force)
        --                 pcall(highlight_win, win, force)
        --             end
        --             require("todo-comments").setup {
        --                 colors = {
        --                     error = { "LspDiagnosticsSignError", "ErrorMsg", "#DC2626" },
        --                     warning = { "LspDiagnosticsSignWarning", "WarningMsg", "#FBBF24" },
        --                     info = { "LspDiagnosticsSignInformation", "#2563EB" },
        --                     hint = { "LspDiagnosticsSignHint", "#10B981" },
        --                     default = { "Identifier", "#7C3AED" },
        --                 }
        --             }
        --         end
        -- }
        use 'Ron89/thesaurus_query.vim'
        use {
            'nvim-telescope/telescope.nvim',
            requires = { {'nvim-lua/plenary.nvim'} }
        }
        use 'stevearc/dressing.nvim'
        use 'nvim-telescope/telescope-project.nvim'
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use {
            'rcarriga/nvim-notify',
            opt= false,
            config = function ()
            end
        }
        use { "williamboman/mason.nvim",
                config = function ()
                    require("mason").setup()
                end
            }
        use { 'williamboman/mason-lspconfig.nvim',
                config = function ()
                    require("mason-lspconfig").setup()
                end,
                requires = "williamboman/mason.nvim"
            }
        use { 'neovim/nvim-lspconfig', require = {
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
            }
            }
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use {'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    require("core.null-ls").setup()
                end
            }
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'simrat39/rust-tools.nvim'
        --use 'ThePrimeagen/vim-be-good'
        --use 'kevinhwang91/nvim-bqf'
        use 'L3MON4D3/LuaSnip'
        use 'saadparwaiz1/cmp_luasnip'
        --use 'rafamadriz/friendly-snippets'
        -- use { 'phaazon/hop.nvim', config = function ()
        --     require'hop'.setup()
        -- end}
        use {
            'nvim-treesitter/nvim-treesitter',
            config = function()
                require("core.treesitter").setup()
            end
        }

        use {
            "nvim-neorg/neorg",
            -- tag = "latest",
            tag = "*",
            opt = true,
            ft = "norg",
            opt= true,
            after = "nvim-treesitter", -- You may want to specify Telescope here as well
            config = function()
                require('neorg').setup {
                    load = {
                        ["core.defaults"] = {},
                        ["core.norg.completion"] = {
                           config = { -- Note that this table is optional and doesn't need to be provided
                               -- Configuration here
                                engine = "nvim-cmp"
                           }
                        },
                        ["core.norg.concealer"] = {}
                    }
                }
            end
        }
        use 'nvim-treesitter/nvim-treesitter-textobjects'
        use 'nvim-treesitter/playground'
        use 'bkad/camelcasemotion'
        use 'michaeljsmith/vim-indent-object'
        use 'mattn/emmet-vim'
        -- use 'neovimhaskell/haskell-vim' -- BECAUSE HASKELL TREESITTER IS SLOW AS SHIT
        use {"Pocco81/true-zen.nvim", config = function()
                require("core.truezen").setup()
            end
        }
        -- Only add papyrus if I am on a windows machine
        if isWindows then
            -- use 'sirtaj/vim-papyrus'
            use '~/Documents/Git/vim-papyrus4'
        end
            if packer_bootstrap then
                require('packer').sync()
            end
        end,
    config = {
        display = {
            open_fn = require('packer.util').float,
        }
    }
}
)
