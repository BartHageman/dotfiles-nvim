local function hilink(lhs, rhs)
    vim.api.nvim_set_hl(0, lhs, {link = rhs})
end


function ColorMeSurprised(color)
    color = color or "gruvbox-material"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "TelescopePromptPrefix", {link = "Normal"})
    if vim.fn.has("win32") ~= 1 and not vim.g.neovide then
        vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
        vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
    end
    hilink("DiagnosticVirtualTextError", "DiagnosticSignError")
    hilink("DiagnosticVirtualTextWarn", "DiagnosticSignWarn")
    hilink("DiagnosticVirtualTextInfo", "DiagnosticSignInfo")
    hilink("DiagnosticVirtualTextHint", "DiagnosticSignHint")
end

ColorMeSurprised()
