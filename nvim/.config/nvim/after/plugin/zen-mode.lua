require("no-neck-pain").setup({
    fallbackOnBufferDelete = true
})
vim.keymap.set("n", "<leader>z", function() vim.cmd("NoNeckPain") end, { desc = "Toggle NoNeckPain" })
