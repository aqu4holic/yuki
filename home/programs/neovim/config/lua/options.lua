require("nvchad.options")
vim.g.lua_snippets_path = vim.fn.stdpath("config") .. "/lua/luasnip"

vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set("x", "p", function()
    return 'pgv"' .. vim.v.register .. "y"
end, { remap = false, expr = true })

-- render whitespace
vim.opt.list = true;
vim.opt.listchars = {
    space = '·',
    tab = '>·',
    extends = '›',
    precedes = '‹',
    nbsp = '·',
    trail = '·'
}

-- relative numbering
-- vim.opt.number = true
-- vim.opt.relativenumber = true
-- vim.opt.signcolumn = "number"

require("autocmds")