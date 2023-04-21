local util = require('BartH/util')
local my_options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- space in the neovim command line for displaying messages
    colorcolumn = "99999", -- fixes indentline for now
    completeopt = { "menu", "menuone", "noselect"},
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    foldcolumn = '1',
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldlevel= 99,
    foldlevelstart = 99,
    foldenable = true,
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    background = "dark",
    -- title = true, -- set the title of window to the value of the titlestring
    -- -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    undodir = util.join_paths(vim.fn.stdpath("cache"), "undo"), -- set an undo directory
    undofile = true, -- enable persistent undo
    updatetime = 150, -- faster completion
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- convert tabs to spaces
    shiftwidth = 4, -- the number of spaces inserted for each indentation
    tabstop = 4, -- insert 2 spaces for a tab
    cursorline = false, -- highlight the current line
    number = true, -- set numbered lines
    relativenumber = true, -- set relative numbered lines
    numberwidth = 4, -- set number column width {default 4}
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    wrap = false, -- display lines as one long line
    spell = false,
    spelllang = "en",
    dictionary =  util.join_paths(vim.fn.stdpath("config"), ".dictionary"),
    scrolloff = 10,
    sidescrolloff = 10,
    incsearch = true,
    inccommand = "nosplit",
    laststatus = 3,
    fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]],
    guifont = "JetBrainsMono NF:h14"
}
---  SETTINGS  ---
vim.opt.shortmess:append "cs" -- Don't show search wrapped messages

for k, v in pairs(my_options) do
    vim.opt[k] = v
end


if vim.g.neovide then
    local isWindows = vim.loop.os_uname().version:match "Windows"
    if isWindows then 
        vim.g.neovide_refresh_rate=160
    else
        vim.g.neovide_refresh_rate=60
    end
    vim.g.neovide_cursor_trail_length=0.001
    vim.g.neovide_cursor_animation_length=0.023
    vim.g.neovide_input_use_logo=true
    vim.g.neovide_floating_blur_amount_x=5.0
    vim.g.neovide_floating_blur_amount_y=5.0
    vim.opt.guifont = "Iosevka:h14"
end

-- vim.cmd("let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']")
vim.cmd("let g:user_emmet_leader_key='<C-Z>'")
