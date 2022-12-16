local M = {}

M.setup = function()
    local cmd = vim.cmd
        cmd "au ColorScheme * hi clear DiagnosticVirtualTextError"
        cmd "au ColorScheme * hi clear DiagnosticVirtualTextWarn"
        cmd "au ColorScheme * hi clear DiagnosticVirtualTextInfo"
        cmd "au ColorScheme * hi clear DiagnosticVirtualTextHint"

        cmd "au ColorScheme * hi link DiagnosticVirtualTextError DiagnosticSignError   "
        cmd "au ColorScheme * hi link DiagnosticVirtualTextWarn DiagnosticSignWarn   "
        cmd "au ColorScheme * hi link DiagnosticVirtualTextInfo DiagnosticSignInfo   "
        cmd "au ColorScheme * hi link DiagnosticVirtualTextHint DiagnosticSignHint   "
        cmd "au ColorScheme * hi IndentBlanklineIndent1 guifg=#52524c"
        cmd "au ColorScheme * hi LineNr guifg=#d4be98"
        cmd "au ColorScheme * hi LineNrAbove guifg=#9c8775"
        cmd "au ColorScheme * hi LineNrBelow guifg=#9c8775"
        cmd "au ColorScheme * hi link CmpItemMenu Comment"
        -- cmd "au ColorScheme * hi EndOfBuffer guifg=bg guibg=bg"
    if customsettings.transparent_window then
        cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"
        cmd "au ColorScheme * hi SignColumn ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NormalNC ctermbg=none guibg=none"
        cmd "au ColorScheme * hi MsgArea ctermbg=none guibg=none"
        cmd "au ColorScheme * hi TelescopeBorder ctermbg=none guibg=none"
        cmd "au ColorScheme * hi NvimTreeNormal ctermbg=none guibg=none"
        cmd "au ColorScheme * hi LineNr ctermbg=none guibg=none"
        cmd "au ColorScheme * hi EndOfBuffer ctermbg=none guibg=none"
        -- cmd "au ColorScheme * hi GitSignsAdd ctermbg=none guibg=none" FIX: this removes the text color
        -- cmd "au ColorScheme * hi GitSignsChange ctermbg=none guibg=none"
        -- cmd "au ColorScheme * hi GitSignsDelete ctermbg=none guibg=none"
        cmd "au ColorScheme * hi Folded ctermbg=none guibg=none"
        cmd "let &fcs='eob: '"
    end
    vim.cmd("colorscheme " .. "gruvbox-material")
end
return M
