vim.keymap.set("n", "<leader>t", function() require("trouble").toggle() end, { desc = "[T]rouble toggle" })

vim.keymap.set("n", "<leader>tt",
    function()
        require("trouble").toggle(
            {
                mode = "todo",
                filter = { buf = 0 },
            }
        )
    end,
    { desc = "[T]rouble toggle [t]odo file" }
)

vim.keymap.set("n", "<leader>ttp",
    function()
        require("trouble").toggle("todo")
    end,
    { desc = "[T]rouble toggle [t]odo [p]roject" }
)

vim.keymap.set("n", "<leader>td",
    function()
        require("trouble").toggle(
            {
                mode = "diagnostics",
                filter = { buf = 0 }
            }
        )
    end,
    { desc = "[T]rouble [d]iagnostics file" }
)

vim.keymap.set("n", "<leader>tdp",
    function()
        require("trouble").toggle("diagnostics")
    end,
    { desc = "[T]rouble toggle [d]iagnostics [p]roject" }
)

vim.keymap.set("n", "<leader>tq", function() require("trouble").toggle("quickfix") end, { desc = "[T]rouble [q]uickfix" })
vim.keymap.set("n", "<leader>tl", function() require("trouble").toggle("loclist") end, { desc = "[T]rouble [l]oclist" })
