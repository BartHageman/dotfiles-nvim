local M = {}
local util = require "util"
M.load_options = function()
  local default_options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- allows neovim to access the system clipboard
    cmdheight = 1, -- space in the neovim command line for displaying messages
    colorcolumn = "99999", -- fixes indentline for now
    completeopt = { "menu", "menuone", "noselect"},
    conceallevel = 0, -- so that `` is visible in markdown files
    fileencoding = "utf-8", -- the encoding written to a file
    foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
    foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    -- foldexpr = "nvim_treesitter#foldexpr()", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
    foldlevelstart = 99,
    hidden = true, -- required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    mouse = "a", -- allow the mouse to be used in neovim
    pumheight = 10, -- pop up menu height
    showmode = true, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 2, -- always show tabs
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    termguicolors = true, -- set term gui colors (most terminals support this)
    background = "dark",
    --timeoutlen = 100, -- time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- set the title of window to the value of the titlestring
    -- opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
    undodir = util.join_paths(util.get_cache_dir(), "undo"), -- set an undo directory
    undofile = true, -- enable persistent undo
    updatetime = 300, -- faster completion
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
    dictionary = util.join_paths(vim.env.VIMHOMEDIR, "words"),
    scrolloff = 0,
    sidescrolloff = 10,
    incsearch = true,
    inccommand = "nosplit",
    laststatus = 3
  }

  ---  SETTINGS  ---

  vim.opt.shortmess:append "cs" -- Don't show search wrapped messages

  for k, v in pairs(default_options) do
    vim.opt[k] = v
  end
  vim.cmd("let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']")
  vim.cmd("let g:user_emmet_leader_key='<C-Z>'")
  vim.cmd("set fillchars+=fold:\\ ")
  vim.cmd([[
  set foldtext=FoldText()
  function! FoldText()
  let l:lpadding = &fdc
  redir => l:signs
  execute 'silent sign place buffer='.bufnr('%')
  redir End
  let l:lpadding += l:signs =~ 'id=' ? 2 : 0

  if exists("+relativenumber")
  if (&number)
      let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 2
  elseif (&relativenumber)
      let l:lpadding += max([&numberwidth, strlen(v:foldstart - line('w0')), strlen(line('w$') - v:foldstart), strlen(v:foldstart)]) + 1
  endif
  else
     if (&number)
     let l:lpadding += max([&numberwidth, strlen(line('$'))]) + 1
     endif
     endif

     " expand tabs
     let l:start = substitute(getline(v:foldstart), '\t', repeat(' ', &tabstop), 'g')
     let l:end = substitute(substitute(getline(v:foldend), '\t', repeat(' ', &tabstop), 'g'), '^\s*', '', 'g')

     let l:info = '(' . (v:foldend - v:foldstart) . ')'
     let l:infolen = strlen(substitute(l:info, '.', 'x', 'g'))
     let l:width = winwidth(0) - l:lpadding - l:infolen

     let l:separator = ' …  '
     let l:separatorlen = strlen(substitute(l:separator, '.', 'x', 'g'))
     let l:start = strpart(l:start , 0, l:width - strlen(substitute(l:end, '.', 'x', 'g')) - l:separatorlen)
     let l:text = l:start . ' …  ' . l:end

     return l:info . " 祉 " . l:text . repeat(' ', l:width - strlen(substitute(l:text, ".", "x", "g")))
  endfunction
  set fillchars+=diff:╱
  ]])
end

M.load_commands = function()
  local cmd = vim.cmd
  if customsettings.line_wrap_cursor_movement then
    cmd "set whichwrap+=<,>,[,],h,l"
  end
end
M.setup = function()
    M.load_options()
    customsettings = {}
    local isWindows = vim.loop.os_uname().version:match "Windows"
    if (isWindows) then
        vim.cmd[[let g:gruvbox_material_background = 'soft']]
    end
    customsettings.transparent_window = false --not isWindows and not vim.g.neovide
end

return M
