require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
-- vim.keymap.set('n', '<leader>p', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })

local find_files = function()
    local job_id = vim.fn.jobstart({ "git", "status" })
    local exit_codes = vim.fn.jobwait({ job_id }, 200)
    local exit_code = exit_codes[1]
    if exit_code < 0 then
        vim.api.nvim_err_writeln("[find_files] 'git status' job failed with code " .. tostring(exit_code))
    elseif exit_code == 0 then
        require('telescope.builtin').git_files({ show_untracked = true })
    else
        require('telescope.builtin').find_files()
    end
end

-- vim.keymap.set('n', '<C-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>P', require('telescope.builtin').git_files, { desc = '[S]earch git [F]iles' })
vim.keymap.set('n', '<leader>p', find_files, { desc = '[S]earch git [F]iles' })
vim.keymap.set('n', '<leader>P', function()
    require('telescope.builtin').find_files({
        find_command = { "fd", "--max-depth=1", "--hidden" }
    })
end
, { desc = 'Search for files in buffer directory' })

vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>F', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sf', function()
        require('telescope.builtin').live_grep({
            grep_open_files = true
        })
    end,
    { desc = '[S]earch in open [F]iles' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
