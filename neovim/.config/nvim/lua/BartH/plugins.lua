-- local ensure_packer = function()
--   local fn = vim.fn
--   local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
--   if fn.empty(fn.glob(install_path)) > 0 then
--     fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
--     vim.cmd [[packadd packer.nvim]]
--     return true
--   end
--   return false
-- end
--
-- local packer_bootstrap = ensure_packer()
--
-- local packer_group = vim.api.nvim_create_augroup('Packer', {clear = true})
-- vim.api.nvim_create_autocmd('BufWritePost', {
--     command = 'source <afile> | PackerCompile',
--     group = packer_group,
--     pattern = vim.fn.expand('$MYVIMRC')
-- })
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

vim.g.mapleader = " "
vim.g.maplocalleader = " "

return require('lazy').setup({
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'sainnhe/gruvbox-material',
            'tpope/vim-surround',
            'tpope/vim-repeat',
            'andymass/vim-matchup',
            'moll/vim-bbye', -- Delete buffers without messing up stuff.
            {
                'j-hui/fidget.nvim',
                config = function()
                    require("fidget").setup{text = {spinner="dots"}}
                end
            },


            -- Git stuff
     --        use { 'TimUntersberger/neogit', dependencies = 'nvim-lua/plenary.nvim', 
     --        config = function() 
     --                require('BartH.setups.neogit') 
     --            end
	    -- }
     --        use { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' }
            'aymericbeaumet/vim-symlink',
            'tpope/vim-fugitive',
            'ThePrimeagen/git-worktree.nvim',
            {
                'lewis6991/gitsigns.nvim',
                dependencies = {
                    'nvim-lua/plenary.nvim'
                },
                config = function()
                   require("BartH.setups.gitsigns")
                end
            },

            { 'mbbill/undotree'},
            {
                "folke/trouble.nvim",
                dependencies = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {}
                end
            },
            'tpope/vim-abolish',
            {
                'numToStr/Comment.nvim',
                config = function()
                    require('Comment').setup()
                end
            },
            'godlygeek/tabular',
            {
              'romgrk/barbar.nvim',
              dependencies = {'kyazdani42/nvim-web-devicons'}
            },
            {
                "lukas-reineke/indent-blankline.nvim",
                config=function()
                    require('BartH.setups.indent-blankline')
                end
            }, -- Indicate indentation levels with lines
            'kyazdani42/nvim-web-devicons', -- for file icons
            {
                's1n7ax/nvim-window-picker',
                version = "1.*",
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
            },
            {
              "nvim-neo-tree/neo-tree.nvim",
                branch = "v2.x",
                dependencies = {
                  "nvim-lua/plenary.nvim",
                  "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
                  "MunifTanjim/nui.nvim",
                  "s1n7ax/nvim-window-picker"
                },
                 config = function()
                    require("BartH.setups.neotree")
                end
              },
            'unblevable/quick-scope',
            {
                'hoob3rt/lualine.nvim',
                dependencies = {'kyazdani42/nvim-web-devicons'},
                config = function()
                    require('BartH.setups.lualine')
                end
		},
        {
            'nvim-telescope/telescope.nvim',
            dependencies = {'nvim-lua/plenary.nvim' },
            config = function()
                        require('BartH.setups.telescope')
                     end
        },
        'stevearc/dressing.nvim',
        'nvim-telescope/telescope-project.nvim',
        {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-symbols.nvim',
        {
            'rcarriga/nvim-notify',
            lazy= false,
            config = function ()
                require('BartH.setups.notify')
            end
        },

        -- LSP STUFF

        { "williamboman/mason.nvim"},
        { 'williamboman/mason-lspconfig.nvim'},
        { 'neovim/nvim-lspconfig'},
        -- CMP
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        {  'saadparwaiz1/cmp_luasnip',
            config = function()
                    require('BartH.setups.luasnip')
                end
            },
        {'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    require('BartH.setups.null-ls')
                end
            },
        'ThePrimeagen/vim-be-good',
        --use 'kevinhwang91/nvim-bqf'
        'L3MON4D3/LuaSnip',
        'VonHeikemen/lsp-zero.nvim',
        --use 'rafamadriz/friendly-snippets'
        -- use { 'phaazon/hop.nvim', config = function ()
        --     require'hop'.setup()
        -- end}
        {
            'nvim-treesitter/nvim-treesitter',
            build = ':TSUpdate',
            config = function()
                        require('BartH.setups.treesitter')
                     end
        },
        'simrat39/rust-tools.nvim',

        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/playground',
        'bkad/camelcasemotion',
        'michaeljsmith/vim-indent-object',
        'mattn/emmet-vim',
        -- Packer
        {"Pocco81/true-zen.nvim", config = function()
                require("BartH.setups.truezen")
            end
        },
        'ggandor/leap.nvim',

        {'kevinhwang91/nvim-ufo', dependencies = 'kevinhwang91/promise-async', config = function()
                require('BartH.setups.ufo')
            end
        },
        -- Only add papyrus if I am on a windows machine
        -- if isWindows then
        --     -- use 'sirtaj/vim-papyrus'
        --     use '~/Documents/Git/vim-papyrus4'
        -- end
}
)

