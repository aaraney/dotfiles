local dap = require('dap')
require("dapui").setup()
require("nvim-dap-virtual-text").setup()

-- setup language daps
require('dap-go').setup()

-- keymap remaps

vim.keymap.set('n', '<F1>', dap.continue, { desc = "continue" })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = "step over" })
vim.keymap.set('n', '<F3>', dap.step_into, { desc = "step into" })
vim.keymap.set('n', '<F4>', dap.step_out, { desc = "step out" })
vim.keymap.set('n', '<F5>', dap.restart, { desc = "restart" })
vim.keymap.set('n', '<Leader>b', dap.toggle_breakpoint)

local dapui = require("dapui")
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
end
