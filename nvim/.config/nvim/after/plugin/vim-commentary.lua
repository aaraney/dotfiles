-- remap gcc to M-/
vim.keymap.set({ "n", "v" }, "<M-/>", function()
    local mode = vim.api.nvim_get_mode()["mode"]
    if mode == "n" then
        vim.cmd("Commentary")
        return
    end
    vim.cmd.normal("gcc")
end)
