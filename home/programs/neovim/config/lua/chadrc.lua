local M = {}

M.ui = {
    hl_add = require("highlights").add,
	hl_override = require("highlights").override,

    -- theme = "catppuccin",
    theme = "tokyodark",
    transparency = true,

    tabufline = {
        order = { "treeOffset", "buffers", "tabs" },
    },

    statusline = {
        theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
    },
}

return M
