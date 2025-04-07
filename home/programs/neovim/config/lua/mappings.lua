require("nvchad.mappings")
require('Comment').setup()

local map = vim.keymap.set
local create_user_command = vim.api.nvim_create_user_command
local create_autocmd = vim.api.nvim_create_autocmd
-- local nomap = vim.keymap.del
-- local keymap = vim.api.nvim_set_keymap
-- local function remap(mode, from, to)
--   keymap(mode, from, to, opts)
-- end

-- autosave
local auto_save_toggled = true
local auto_save_group = vim.api.nvim_create_augroup('auto_save_group', { clear = true })

local function clear_cmdarea(duration)
    vim.defer_fn(function()
        vim.api.nvim_echo({}, false, {})
    end, duration)
end

local function create_auto_save()
    vim.api.nvim_clear_autocmds({group = auto_save_group})

    if (auto_save_toggled) then
        -- vim.api.nvim_create_augroup('auto_save_group', { clear = true })

        create_autocmd({ "InsertLeave", "TextChanged" }, {
            group = auto_save_group,
            callback = function()
                local bufname = vim.api.nvim_buf_get_name(0)
                if bufname ~= 0 and vim.bo.buflisted and vim.fn.filereadable(bufname) == 1 then
                    vim.cmd "silent w"

                    -- local filename = string.gsub(vim.api.nvim_buf_get_name(0), vim.loop.cwd(), '')
                    local filename = vim.fn.expand('%:t')
                    local time = os.date "%I:%M %p"

                    -- print nice colored msg
                    vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " " .. filename .. " autosaved at " .. time } }, false, {})

                    clear_cmdarea(1000)
                end
            end,
        })
    end
end

create_auto_save()

function toggle_auto_save()
    auto_save_toggled = not auto_save_toggled

    create_auto_save()

    local state = auto_save_toggled and "enabled" or "disabled"

    vim.api.nvim_echo({ { "󰄳", "LazyProgressDone" }, { " Autosave is now " .. state } }, false, {})

    clear_cmdarea(1000)
end

-- toggle autosave
create_user_command('ToggleAutoSave', toggle_auto_save, {})
map('n', '<F6>', '<cmd>lua toggle_auto_save()<CR>', { noremap = true, silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })

-- map("n", "<leader>fm", function()
-- 	require("conform").format()
-- end, { desc = "File Format with conform" })

-- no need because of using better-escape.neovim
-- "jj" and "jk" are mapped to <ESC>
-- map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

map("n", "<Esc>", "<Esc><cmd>noh<CR>", { desc = "general clear highlights" })
map("n", "j", "gj", { desc = "Move down in wrapped line" })
map("n", "k", "gk", { desc = "Move up in wrapped line" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- fzf-lua
map("n", "<A-w>", "<cmd>FzfLua live_grep<CR>", { desc = "FzfLua Live grep" })
map("n", "<A-f>", "<cmd>FzfLua lgrep_curbuf<CR>", { desc = "FzfLua Find in current buffer" })
map("n", "<A-r>", "<cmd>FzfLua oldfiles<CR>", { desc = "FzfLua Find old files" })
map("n", "<A-o>", "<cmd>FzfLua files<CR>", { desc = "FzfLua Find files" })
map("n", "<A-b>", "<cmd>FzfLua buffers<CR>", { desc = "FzfLua Find opened files" })

map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "FzfLua find files" })
map("n", "<leader>fw", "<cmd>FzfLua live_grep<CR>", { desc = "FzfLua live grep" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "FzfLua find buffers" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<CR>", { desc = "FzfLua help page" })
map("n", "<leader>ma", "<cmd>FzfLua marks<CR>", { desc = "FzfLua find marks" })
map("n", "<leader>fo", "<cmd>FzfLua oldfiles<CR>", { desc = "FzfLua find oldfiles" })
map("n", "<leader>fz", "<cmd>FzfLua zoxide<CR>", { desc = "FzfLua change to recent folders" })
map("n", "<leader>cm", "<cmd>FzfLua git_commits<CR>", { desc = "FzfLua git commits" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<CR>", { desc = "FzfLua git status" })

map("n", "mm", ":b#<CR>", { desc = "Open last visited buffer" })
map("n", "<C-z>", function()
    vim.cmd(string.format("silent :wa"))
    vim.cmd(string.format("silent :qa!"))
end, { desc = "Save all and close nvim" })
-- faster nav
-- map({ 'n', 'v' }, 'H', '^', { noremap = true })
-- map({ 'n', 'v' }, 'L', '$', { noremap = true })
-- map({ 'n', 'v' }, 'J', '<C-d>', { noremap = true })
-- map({ 'n', 'v' }, 'K', '<C-u>', { noremap = true }) -- mapped in lsp config also
-- map("n", "<left>", '<cmd>echo "Use h to move!!"<CR>', { noremap = true })
-- map("n", "<right>", '<cmd>echo "Use l to move!!"<CR>', { noremap = true })
-- map("n", "<up>", '<cmd>echo "Use k to move!!"<CR>', { noremap = true })
-- map("n", "<down>", '<cmd>echo "Use j to move!!"<CR>', { noremap = true })

map("n", "<leader>lg", "<cmd>LazyGit <CR>", { desc = "LazyGit Open" })
map("n", "<leader>ls", "<cmd>Lazy sync <CR>", { desc = "Lazy Sync Config" })

-- tabs
map("n", "<Leader>t", ":tabnew<CR>", { noremap = true, silent = true, desc = "Open a new tab" })
map("n", "<Leader>tq", ":tabclose<CR>", { noremap = true, silent = true, desc = "Close tab" })
map("n", "<Leader>tb", ":tabprev<CR>", { noremap = true, silent = true, desc = "Switch to the previous tab" })
map("n", "<Leader>tn", ":tabnext<CR>", { noremap = true, silent = true, desc = "Switch to the next tab" })
map("n", "<Leader><Tab>", ":tabnext<CR>", { noremap = true, silent = true, desc = "Switch to the next tab" })
map("n", "<Leader><S-Tab>", ":tabprev<CR>", { noremap = true, silent = true, desc = "Switch to the previous tab" })

function TabMoveWithWrap(dir)
    local current_tab = vim.fn.tabpagenr()  -- Get current tab page number
    local total_tabs = vim.fn.tabpagenr('$')  -- Get total number of tabs

    -- Calculate the new tab index with wrap-around
    local new_tab = current_tab + dir
    if new_tab < 1 then
        new_tab = total_tabs  -- Wrap to the last tab if moving left from the first tab
    elseif new_tab > total_tabs then
        new_tab = 0  -- Wrap to the first tab if moving right from the last tab
    else
        if (dir < 0) then
            vim.cmd('tabmove ' .. dir)
        else
            vim.cmd('tabmove +' .. dir)
        end
        return
    end

    -- Move to the new tab
    vim.cmd('tabmove ' .. new_tab)
end

map("n", "<Leader>th", function() TabMoveWithWrap(-1) end, { noremap = true, silent = true, desc = "Move tab left" })
map("n", "<Leader>tl", function() TabMoveWithWrap(1) end, { noremap = true, silent = true, desc = "Move tab right" })
map("n", "<Leader>tj", function() TabMoveWithWrap(-1) end, { noremap = true, silent = true, desc = "Move tab left" })
map("n", "<Leader>tk", function() TabMoveWithWrap(1) end, { noremap = true, silent = true, desc = "Move tab right" })
map("n", "<C-,>", function() TabMoveWithWrap(-1) end, { noremap = true, silent = true, desc = "Move tab left" })
map("n", "<C-.>", function() TabMoveWithWrap(1) end, { noremap = true, silent = true, desc = "Move tab right" })

map("n", "<C-1>", ":tabn 1<CR>", { noremap = true, silent = true, desc = "Switch to tab 1" })
map("n", "<C-2>", ":tabn 2<CR>", { noremap = true, silent = true, desc = "Switch to tab 2" })
map("n", "<C-3>", ":tabn 3<CR>", { noremap = true, silent = true, desc = "Switch to tab 3" })
map("n", "<C-4>", ":tabn 4<CR>", { noremap = true, silent = true, desc = "Switch to tab 4" })
map("n", "<C-5>", ":tabn 5<CR>", { noremap = true, silent = true, desc = "Switch to tab 5" })
map("n", "<C-6>", ":tabn 6<CR>", { noremap = true, silent = true, desc = "Switch to tab 6" })
map("n", "<C-7>", ":tabn 7<CR>", { noremap = true, silent = true, desc = "Switch to tab 7" })
map("n", "<C-8>", ":tabn 8<CR>", { noremap = true, silent = true, desc = "Switch to tab 8" })
map('n', '<C-9>', ':tablast<CR>', {noremap = true, silent = true})

-- Line-wise comment toggle with Ctrl + /
vim.keymap.set('n', '<C-/>', '<Plug>(comment_toggle_linewise_current)', { noremap = true, silent = true })
vim.keymap.set('v', '<C-/>', '<Plug>(comment_toggle_linewise_visual)', { noremap = true, silent = true })

-- Block-wise comment toggle with Ctrl + Shift + /
vim.keymap.set('n', '<C-S-/>', '<Plug>(comment_toggle_blockwise_current)', { noremap = true, silent = true })
vim.keymap.set('v', '<C-S-/>', '<Plug>(comment_toggle_blockwise_visual)', { noremap = true, silent = true })

-- Visual Block mode for comments
vim.keymap.set('x', '<C-/>', '<Plug>(comment_toggle_linewise_visual)', { noremap = true, silent = true })
vim.keymap.set('x', '<C-S-/>', '<Plug>(comment_toggle_blockwise_visual)', { noremap = true, silent = true })

-- portal
map("n", "<leader>o", "<cmd>Portal jumplist backward<CR>", { desc = "Portal Backward" })
map("n", "<leader>i", "<cmd>Portal jumplist forward<CR>", { desc = "Portal Forward" })
map("n", "<leader>co", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

-- resize splits
-- Resize vertical split (increase width) using <A-+>
vim.keymap.set('n', '<A-=>', function()
    vim.cmd('vertical resize +1')  -- Increase the width of the active split by 5 columns
end)

-- Resize vertical split (decrease width) using <A-->
vim.keymap.set('n', '<A-->', function()  -- <A--> is mapped as <A-=> on some systems
    vim.cmd('vertical resize -1')  -- Decrease the width of the active split by 5 columns
end)

-- Resize horizontal split (increase height) using <A-Shift-+>
vim.keymap.set('n', '<A-S-=>', function()
    vim.cmd('resize +1')  -- Increase the height of the active split by 5 lines
end)

-- Resize horizontal split (decrease height) using <A-Shift-->
vim.keymap.set('n', '<A-S-->', function()
    vim.cmd('resize -1')  -- Decrease the height of the active split by 5 lines
end)

-- Exit terminal input mode when pressing ESC
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

-- -- Open a horizontal terminal with Shift + `
-- vim.keymap.set("n", "<S-`>", function()
--   require("nvchad.term").new({ pos = "sp" })  -- sp = split (horizontal)
-- end)
--
-- -- Open a vertical terminal with Ctrl + Shift + `
-- vim.keymap.set("n", "<C-S-`>", function()
--   require("nvchad.term").new({ pos = "vsp" })  -- vsp = vertical split
-- end)

-- wip code runner function
-- TODO: cleanup, safe execution of c and cpp
-- TODO: execute zig build if build.zig detected in root directory

-- map({ 'n', 't' }, '<C-a>', function()
--   local file = vim.fn.expand '%:t'
--   local fp = vim.fn.expand '%:p:h'
--   local ft = vim.bo.ft
--   require('nvchad.term').runner {
--     id = 'run',
--     pos = 'sp',
--     cmd = function()
--       local ft_cmds = {
--         python = 'python3 ' .. file,
--         cpp = 'zr ' .. file,
--         c = 'zr ' .. file,
--         zig = 'zr ' .. file,
--       }
--       return 'cd ' .. fp .. ' && clear && ' .. ft_cmds[ft]
--     end,
--   }
-- end, { desc = 'Code Runner' })

-- Yes, we're just executing a bunch of Vimscript, but this is the officially
-- endorsed method; see https://github.com/L3MON4D3/LuaSnip#keymaps
-- vim.cmd[[
-- " Use Tab to expand and jump through snippets
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
--
-- " Use Shift-Tab to jump backwards through snippets
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- ]]

-- " Expand or jump in insert mode
-- imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
--
-- " Jump forward through tabstops in visual mode
-- smap <silent><expr> <Tab> luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'
-- " Jump backward through snippet tabstops with Shift-Tab (for example)
-- imap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- smap <silent><expr> <S-Tab> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'
-- imap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
-- smap <silent><expr> <C-f> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-f>'
