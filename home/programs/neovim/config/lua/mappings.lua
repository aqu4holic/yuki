require("nvchad.mappings")

local map = vim.keymap.set
local nomap = vim.keymap.del
local create_user_command = vim.api.nvim_create_user_command
local create_autocmd = vim.api.nvim_create_autocmd
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
map("n", "]]", ":call search('[([{<]')<CR>", { desc = "Move to next opening instance ([{<" })
map("n", "<A-o>", "<cmd> Telescope find_files <CR>", { desc = "Find files" })
map("n", "<A-b>", "<cmd> Telescope buffers <CR>", { desc = "Find opened files" })
map("n", "mm", ":b#<CR>", { desc = "Open last visited buffer" })
map("n", "<C-z>", function()
    vim.cmd(string.format("silent :wa"))
    vim.cmd(string.format("silent :qa"))
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

map("n", "<leader>lg", "<cmd> LazyGit <CR>", { desc = "LazyGit Open" })
map("n", "<leader>ls", "<cmd> Lazy sync <CR>", { desc = "Lazy Sync Config" })
map("n", "<leader>fp", "<cmd> Telescope neovim-project discover <CR>", { desc = "Telescope Find projects" })

-- map('n', '<leader>tt', '<cmd> tabnew <CR>', { desc = 'Tab Create new' })
-- map('n', '<leader>tn', '<cmd> tabnext <CR>', { desc = 'Tab Switch next' })

-- map('n', '<leader>ww', '<cmd> HopWord <CR>', { desc = 'Hop' })

vim.api.nvim_set_keymap('n', '<C-1>', '1gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-2>', '2gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-3>', '3gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-4>', '4gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-5>', '5gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-6>', '6gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-7>', '7gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-8>', '8gt', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-9>', ':tablast<CR>', {noremap = true, silent = true})

map("n", "<leader>o", "<cmd>Portal jumplist backward<CR>", { desc = "Portal Backward" })
map("n", "<leader>i", "<cmd>Portal jumplist forward<CR>", { desc = "Portal Forward" })

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
