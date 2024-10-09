vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""
vim.opt.mouse = "a"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

local scrolloff_default = 8
vim.opt.scrolloff = scrolloff_default

-- toggle keep cursor in center of screen
vim.api.nvim_create_user_command("Follow",
    function(_)
        local value = vim.api.nvim_get_option("scrolloff")
        if value == scrolloff_default then
            vim.api.nvim_set_option("scrolloff", 999)
            return
        end
        vim.api.nvim_set_option("scrolloff", scrolloff_default)
    end,
    {}
)

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.colorcolumn = "80"

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Turn on spelling
vim.opt.spell = true

-- Highlight on yank
-- Cool highlighting courtesy of @clason
-- adapted from https://github.com/tjdevries/config_manager/blob/ee11710c4ad09e0b303e5030b37c86ad8674f8b2/xdg_config/nvim/after/plugin/on_yank.vim#L4
vim.api.nvim_create_augroup("LuaHighlight", { clear = true })
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "Substitute",
            timeout = 150,
            on_macro = true
        })
    end

})
