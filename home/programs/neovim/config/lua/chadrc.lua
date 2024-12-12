local M = {}

M.ui = {
    tabufline = {
        lazyload = false,
        order = { "buffers", "tabs", "btns", "treeOffset", },
    },

    statusline = {
        theme = "vscode_colored",

        separator_style = "round",

        order = {
            "mode",
            "git",
            "file",
            "%=",          -- Separator
            "lsp_msg",     -- LSP status message
            "%=",          -- Separator
            "diagnostics",         -- LSP client info
            "encoding",         -- Custom module
            "cursor",         -- Another custom module
            "cwd",         -- Current working directory
        },

        modules = {
            encoding = function()
                local encoding = vim.bo.fileencoding ~= "" and vim.bo.fileencoding or "no encode"
                return "%#st_mode#" .. encoding .. " "
            end,
        },
    },
}

M.base46 = {
	hl_add = require("highlights").add,
	hl_override = require("highlights").override,
	theme = "tokyodark",
	transparency = true,
}

M.term = {
    winopts = {
        number = false,
        winhl = "Normal:Terminal",
    },  -- Window options for terminal (e.g., no line numbers)
    sizes = {
        sp = 0.4,           -- Horizontal split size (30% of window width)
        vsp = 0.4,          -- Vertical split size (20% of window width)
        ["bo sp"] = 0.4,    -- Full window horizontal split
        ["bo vsp"] = 0.4,   -- Full window vertical split (set to 0.2 of window width)
    },
    float = {
        row = 0.1,          -- Floating terminal row position
        col = 0.25,         -- Floating terminal column position
        width = 0.5,        -- Floating terminal width (50% of the window width)
        height = 0.5,       -- Floating terminal height (40% of the window height)
        border = "single",  -- Floating terminal border style
    },
}



return M
