local M = {}
M.setup = function()
    require("indent_blankline").setup {
        char = "│",
        show_current_context = true,
        show_current_context_start = true,
        buftype_exclude = {"terminal", "telescope", "prompt"},
        char_highlight_list = {
            "IndentBlanklineIndent1",
        },
    }
end

return M
