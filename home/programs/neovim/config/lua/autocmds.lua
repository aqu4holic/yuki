local create_autocmd = vim.api.nvim_create_autocmd

-- Ibus typing
local ibus_cur = "BambooUs"
local ibus_en = "BambooUs"

create_autocmd("InsertEnter", {
    pattern = { "*" },
    callback = function()
        os.execute("ibus engine " .. ibus_cur)
    end,
})

create_autocmd("InsertLeave", {
    pattern = { "*" },
    callback = function()
        local f = io.popen("ibus engine", "r")
        if f then
            ibus_cur = f:read("*a")
            f:close()
        end
        os.execute("ibus engine " .. ibus_en)
    end,
})

---@param padding_amount integer
---@param margin_amount integer
local set_spacing = function(padding_amount, margin_amount)
    -- locar command = string.format('kitty @ set-spacing padding=%d margin=%d', padding_amount, margin_amount)
    vim.fn.system({
        "kitty",
        "@",
        "set-spacing",
        "padding=" .. padding_amount,
        "margin=" .. margin_amount,
    })
end

set_spacing(0, 0)

create_autocmd("VimLeave", {
    once = true,
    callback = function()
        set_spacing(0, 20)
    end,
})

-- auto reload buffer when changed
create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    callback = function()
        if vim.api.nvim_get_mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

create_autocmd("FileChangedShellPost", {
    callback = function()
        vim.cmd(([[echohl WarningMsg | echomsg "%s" | echohl None]]):format("File changed on disk. Buffer reloaded."))
    end,
})

-- trim trailing whitespace
create_autocmd({ "BufWritePre", "InsertLeave", "BufWritePost" }, {
    pattern = {"*"},
    callback = function(ev)
        save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})
