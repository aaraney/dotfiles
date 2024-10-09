local harpoon = require("harpoon")
harpoon:setup()

vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = "add buffer to harpoon list" })
vim.keymap.set("n", "<leader>e", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "edit harpoon list" })

vim.keymap.set("n", "<leader>j", function() harpoon:list():select(1) end, { desc = "harpoon 1" })
vim.keymap.set("n", "<leader>k", function() harpoon:list():select(2) end, { desc = "harpoon 2" })
vim.keymap.set("n", "<leader>l", function() harpoon:list():select(3) end, { desc = "harpoon 3" })
vim.keymap.set("n", "<leader>;", function() harpoon:list():select(4) end, { desc = "harpoon 4" })

-- Toggle previous & next buffers stored within Harpoon list
-- vim.keymap.set("n", "<M-S-P>", function() harpoon:list():prev() end)
-- vim.keymap.set("n", "<M-S-N>", function() harpoon:list():next() end)
