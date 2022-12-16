" Miscellaneous remaps
" ====================
let mapleader = " "
let g:camelcasemotion_key = '<leader>'
" Set working directory
" nnoremap <leader>cd :cd %:p:h<CR>

"Insert newline without entering normal mode
" nnoremap <cr> o<esc>
" nnoremap <S-Enter> O<esc>

"Make Y behave like the rest of the capital letters
" nnoremap Y y$

" Pasting over something in visual mode no longer overwrites what you copied.
" vnoremap p "_dP

" Keep screen centered when jumping and concatenating lines
" nnoremap n nzzzv
" nnoremap N Nzzzv
" nnoremap J mzJ`z

" Add an extra undo breakpoint when I type punctuation.
inoremap , ,<c-g>u
inoremap ? ?<c-g>u
inoremap ! !<c-g>u
inoremap . .<c-g>u

" Add extra jumplist points
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" Modify buffer size

nnoremap <M-J>    :resize -2<CR>
nnoremap <M-K>    :resize +2<CR>
nnoremap <M-H>    :vertical resize -2<CR>
nnoremap <M-L>    :vertical resize +2<CR>

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Quickfix list remaps stolen from Theprimagen
" TODO: Possibly change these?
nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz
nnoremap <C-q> :call ToggleQFList(1)<CR>
nnoremap <leader>q :call ToggleQFList(0)<CR>

let g:the_primeagen_qf_l = 0
let g:the_primeagen_qf_g = 0

fun! ToggleQFList(global)
    if a:global
        if g:the_primeagen_qf_g == 1
            let g:the_primeagen_qf_g = 0
            cclose
        else
            let g:the_primeagen_qf_g = 1
            copen
        end
    else
        if g:the_primeagen_qf_l == 1
            let g:the_primeagen_qf_l = 0
            lclose
        else
            let g:the_primeagen_qf_l = 1
            lopen
        end
    endif
endfun

function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <leader>ss :call SynStack()<CR>

" Moving text around

vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
inoremap <M-j> <esc>:m .+1<CR>==
inoremap <M-k> <esc>:m .-2<CR>==
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==

" Terminals inside neovim can be exited like a normal person
tnoremap <esc> <C-\><C-N>
"open terminal and go into insert mode in the terminal
"nnoremap <leader>ot <cmd>vsplit<CR><cmd>term<CR>a 

" nnoremap <leader>tt :NvimTreeToggle<CR>
" nnoremap <leader>tr :NvimTreeRefresh<CR>
" nnoremap <leader>tf :NvimTreeFindFile<CR>

" " LSP config (the mappings used in the default file don't quite work right)
" nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> dn <cmd>lua vim.diagnostic.goto_prev()<CR>
" nnoremap <silent> dp <cmd>lua vim.diagnostic.goto_next()<CR>
" nnoremap <silent> K <cmd>lua vim.lsp.buf.hover({border = "rounded"})<CR>
" nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <leader>ca <cmd>Telescope lsp_code_actions<CR>
" nnoremap <leader>sd <cmd>lua vim.diagnostic.open_float()<CR>

" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
"



" auto-format
" autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)

" nnoremap <silent> <leader>gg :Git<CR>
" nnoremap <silent> <leader>gp :Git push<CR>
" nnoremap <silent> <leader>gP :Git pull<CR>
nnoremap <leader><leader>w <cmd>lua require'hop'.hint_words()<cr>
