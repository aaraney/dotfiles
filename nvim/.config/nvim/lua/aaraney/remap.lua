-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- trying out telescope-file-browser
-- vim.keymap.set("n", "<leader>b", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

--  move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'move focus to the left window', noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'move focus to the right window', noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'move focus to the lower window', noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'move focus to the upper window', noremap = true })

local function wincmd(cmd)
    return function()
        vim.cmd.wincmd(cmd)
    end
end
--  move windows
vim.keymap.set('n', '<C-Space><C-h>', wincmd('H'), { desc = 'move window to left', noremap = true })
vim.keymap.set('n', '<C-Space><C-l>', wincmd('L'), { desc = 'move window to right', noremap = true })
vim.keymap.set('n', '<C-Space><C-j>', wincmd('J'), { desc = 'move window to lower', noremap = true })
vim.keymap.set('n', '<C-Space><C-k>', wincmd('K'), { desc = 'move window to upper', noremap = true })

-- move each sentence in visual selection onto it's own line
vim.keymap.set("v", "s", function()
        local s = vim.fn.getpos('v')[2]
        local e = vim.fn.getcurpos()[2]
        vim.cmd(s .. "," .. e .. "j")
        s = vim.fn.getpos('v')[2]
        e = vim.fn.getcurpos()[2]
        -- just punctuation
        -- vim.cmd(s .. "," .. e .. "s/\\([.!?]\\)[ ]*/\\1\\r/g")
        vim.cmd(s .. "," .. e .. "s/\\(\\[.*\\](.*)\\)[ ]*\\|\\([.!?]\\)[ ]*/\\1\\2\\r/g")
    end,
    { silent = true }
)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- delete word with M-BS
-- vim.keymap.set("i", "<M-BS>", "<C-w>", { desc = "M-BS deletes word like normal" })

-- remap jump back
-- just use <C-t> or <C-o>
-- vim.keymap.set("n", "<M-S-u>", "<C-o>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- remap gq to gw, for whatever reason neovim uses gw instead of gq and I cant
-- get gq out of my hands
vim.keymap.set("v", "gq", "gw", { desc = "gq" })

-- buffer actions
vim.keymap.set("n", "<C-Space>", vim.cmd.bnext, { desc = "next buffer" })
vim.keymap.set("n", "<C-S-Space>", vim.cmd.bprev, { desc = "previous buffer" })
-- had this enabled, not sure why?
-- vim.keymap.set("n", "<F6>", vim.cmd.bprev, { desc = "previous buffer" })
vim.keymap.set("n", "<C-w>", vim.cmd.bd, { desc = "delete buffer", noremap = true })

-- run virtual selection as shell command and paste its output on the next line
vim.keymap.set('x', '<leader>x', function()
        -- yank text into 'a' register
        vim.cmd('normal! "ay')
        local output = vim.fn.system(vim.fn.getreg('a'))
        local rstrip = string.gsub(output, "%s+$", "")
        vim.fn.append(vim.fn.line("'>"), vim.split(rstrip, '\n'))
    end,
    {
        noremap = true,
        silent = true,
        desc = "run virtual selection as shell command and paste its output on the next line"
    })
