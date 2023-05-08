local null_ls = require("null-ls")
require("null-ls").setup({
    sources = {
        -- require("null-ls").builtins.formatting.stylua,
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.formatting.prettierd
        -- require("null-ls").builtins.completion.spell,
    },
})
