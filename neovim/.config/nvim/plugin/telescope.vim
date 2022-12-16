" " Find files using Telescope command-line sugar.
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>gf :lua require('telescope.builtin').git_files()<CR>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" nnoremap <leader>fr <cmd>Telescope oldfiles<cr>
" " nnoremap <leader>f/ <cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending <cr>
" " nnoremap <leader>f/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>
" " nnoremap <leader>f/ <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_ivy())<cr>
" nnoremap <leader>f/ :lua require("core.telescope").grep_current_file()<CR>
"nnoremap <leader>vrc :lua require("core.telescope").search_dotfiles()<CR>

