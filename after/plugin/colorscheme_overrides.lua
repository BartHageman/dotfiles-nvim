vim.cmd [[
  colorscheme rose-pine-moon
]]
vim.api.nvim_set_hl(0, "FoldColumn", {link="Comment"})
-- vim.cmd [[
--   hi EndOfBuffer guibg=#
local function swap_fg_bg(groups)
  for _, name in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
    hl.fg, hl.bg = hl.bg, hl.fg
    local menu_hl = vim.api.nvim_get_hl(0, { name = "PMenu", link = false })
    hl.fg = menu_hl.bg
    vim.api.nvim_set_hl(0, name, hl)
  end
end

swap_fg_bg(
{
"BlinkCmpKindEnum",
"BlinkCmpKindFile",
"BlinkCmpKindText",
"BlinkCmpKindUnit",
"BlinkCmpKindClass",
"BlinkCmpKindColor",
"BlinkCmpKindEvent",
"BlinkCmpKindField",
"BlinkCmpKindValue",
"BlinkCmpKindFolder",
"BlinkCmpKindMethod",
"BlinkCmpKindModule",
"BlinkCmpKindStruct",
"BlinkCmpKindCodeium",
"BlinkCmpKindCopilot",
"BlinkCmpKindKeyword",
"BlinkCmpKindSnippet",
"BlinkCmpKindTabNine",
"BlinkCmpKindConstant",
"BlinkCmpKindFunction",
"BlinkCmpKindOperator",
"BlinkCmpKindProperty",
"BlinkCmpKindVariable",
"BlinkCmpKindInterface",
"BlinkCmpKindReference",
"BlinkCmpKindEnumMember",
"BlinkCmpKindSupermaven",
"BlinkCmpKindConstructor",
"BlinkCmpKindTypeParameter"
}
)
