-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- remap esc
vim.keymap.set("n", "<C-j>", "<Esc>")

-- trying out telescope-file-browser
-- vim.keymap.set("n", "<leader>b", vim.cmd.Ex)
vim.keymap.set("n", "<leader><leader>", vim.cmd.w)
vim.keymap.set("n", "<leader>q", vim.cmd.q)

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
vim.keymap.set("i", "<M-BS>", "<C-w>", {desc = "M-BS deletes word like normal"})

-- remap jump back
vim.keymap.set("n", "<M-S-u>", "<C-o>")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete to void register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- remap gq to gw, for whatever reason neovim uses gw instead of gq and I cant
-- get gq out of my hands
vim.keymap.set("v", "gq", "gw", {desc = "gq"})

-- old spelling stuff that I dont use anymore
-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

-- buffer actions
vim.keymap.set("n", "<M-space>", vim.cmd.bnext, {desc = "next buffer"})
vim.keymap.set("n", "<M-S-space>", vim.cmd.bprev, {desc = "previous buffer"})
vim.keymap.set("n", "<F6>", vim.cmd.bprev, {desc = "previous buffer"})
vim.keymap.set("n", "<M-w>", vim.cmd.bd, {desc = "buffer delete"})
vim.keymap.set("n", "<leader>w", vim.cmd.bd, {desc = "buffer delete"})
