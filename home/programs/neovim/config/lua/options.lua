require("nvchad.options")

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set("x", "p", function()
    return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

-- render whitespace
-- vim.opt.list = true;
-- vim.opt.listchars = {
--     space = '·',
--     tab = '>·',
--     extends = '›',
--     precedes = '‹',
--     nbsp = '·',
--     trail = '·'
-- }

-- relative numbering
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"

-- leap: greying out the search area
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
vim.api.nvim_set_hl(0, "LeapLabelPrimary", {
    fg = "#a6e3a1",
    bg = "black",
    bold = true,
    nocombine = true,
})

vim.api.nvim_set_hl(0, "FlashLabel", {
    fg = "#a6e3a1",
    bg = "black",
    bold = true,
    nocombine = true,
})

-- alpha-nvim: "neovim" header color
vim.api.nvim_set_hl(0, "Type", { fg = "#89b4fa" })

-- vim.g.vscode_snippets_path = {
--     "/home/hynduf/yoru/home/programs/neovim/config/lua/luasnip",
-- }

require("autocmds")
