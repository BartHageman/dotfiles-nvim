local true_zen = require("true-zen")
true_zen.setup({
        ataraxis = {
            options = {
                number = true,
                relativenumber = true,
                signcolumn = "no",
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
