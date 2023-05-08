local true_zen = require("true-zen")
true_zen.setup({
        ataraxis = {
            options = {
                number = true,
                relativenumber = true,
                signcolumn = "yes",
            },
            padding = {
                left = 100
            }
        },
        integrations = {
            tmux = false,
            gitsigns = false,
            lualine = true,
        },
})
