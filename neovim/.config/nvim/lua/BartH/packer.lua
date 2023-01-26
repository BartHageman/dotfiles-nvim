local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

local packer_group = vim.api.nvim_create_augroup('Packer', {clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand('$MYVIMRC')
})

return require('packer').startup(
   {
        function(use)
            local isWindows = vim.loop.os_uname().version:match "Windows"
            use 'wbthomason/packer.nvim'
            use 'nvim-lua/popup.nvim'
            use 'nvim-lua/plenary.nvim'
            use 'sainnhe/gruvbox-material'
            use 'tpope/vim-surround'
            use 'tpope/vim-repeat'
            use 'andymass/vim-matchup'
            use 'moll/vim-bbye' -- Delete buffers without messing up stuff.
            use {
                'j-hui/fidget.nvim',
                config = function()
                    require("fidget").setup{text = {spinner="dots"}}
                end
            }


            -- Git stuff
     --        use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim', 
     --        config = function() 
     --                require('BartH.setups.neogit') 
     --            end
	    -- }
     --        use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
            use 'aymericbeaumet/vim-symlink'
            use 'tpope/vim-fugitive'
            use 'ThePrimeagen/git-worktree.nvim'
            use {
                'lewis6991/gitsigns.nvim',
                requires = {
                    'nvim-lua/plenary.nvim'
                },
                config = function()
                   require("BartH.setups.gitsigns")
                end
            }

            use { 'mbbill/undotree'}
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
            use {
              'romgrk/barbar.nvim',
              requires = {'kyazdani42/nvim-web-devicons'}
            }
            use {
                "lukas-reineke/indent-blankline.nvim",
                config=function()
                    require('BartH.setups.indent-blankline')
                end
            } -- Indicate indentation levels with lines
            use 'kyazdani42/nvim-web-devicons' -- for file icons
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
                 config = function() 
                    require("BartH.setups.neotree")
                end
              }
            use 'unblevable/quick-scope'
            use {
                'hoob3rt/lualine.nvim',
                requires = {'kyazdani42/nvim-web-devicons'},
                config = function()
                    require('BartH.setups.lualine')
                end
		}
        use {
            'nvim-telescope/telescope.nvim',
            requires = {'nvim-lua/plenary.nvim' },
            config = function() 
                        require('BartH.setups.telescope')
                     end
        }
        use 'stevearc/dressing.nvim'
        use 'nvim-telescope/telescope-project.nvim'
        use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use 'nvim-telescope/telescope-symbols.nvim'
        use {
            'rcarriga/nvim-notify',
            opt= false,
            config = function ()
                require('BartH.setups.notify')
            end
        }

        -- LSP STUFF

        use { "williamboman/mason.nvim"}
        use { 'williamboman/mason-lspconfig.nvim'}
        use { 'neovim/nvim-lspconfig'}
        -- CMP
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use {  'saadparwaiz1/cmp_luasnip',
            config = function()
                    require('BartH.setups.luasnip')
                end
            }
        use {'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    require('BartH.setups.null-ls')
                end
            }
        use 'ThePrimeagen/vim-be-good'
        --use 'kevinhwang91/nvim-bqf'
        use 'L3MON4D3/LuaSnip'
        use 'VonHeikemen/lsp-zero.nvim'
        --use 'rafamadriz/friendly-snippets'
        -- use { 'phaazon/hop.nvim', config = function ()
        --     require'hop'.setup()
        -- end}
        use {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = function()
                        require('BartH.setups.treesitter') 
                     end
        }
        use 'simrat39/rust-tools.nvim'

        use 'nvim-treesitter/nvim-treesitter-textobjects'
        use 'nvim-treesitter/playground'
        use 'bkad/camelcasemotion'
        use 'michaeljsmith/vim-indent-object'
        use 'mattn/emmet-vim'
        -- Packer
        use {"Pocco81/true-zen.nvim", config = function()
                require("BartH.setups.truezen")
            end
        }

        use {'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = function() 
                require('BartH.setups.ufo')
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

