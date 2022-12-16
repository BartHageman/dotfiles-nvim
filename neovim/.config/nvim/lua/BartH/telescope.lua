local Mappings = {}
Mappings.search_dotfiles = function()
    require("telescope.builtin").find_files({
        prompt_title = " Search Neovim config ",
        cwd = vim.fn.stdpath("config"),
        hidden = true
    })
end
return Mappings
