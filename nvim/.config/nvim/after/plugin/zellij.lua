local Job = require 'plenary.job'

vim.api.nvim_create_user_command("R", function(args)
    Job:new({
        command = 'zellij',
        args = { 'run', '--name', 'nvim_window', '--floating', '--', 'zsh', '-ic', args.args },
        cwd = vim.fn.getcwd(),
    }):sync()
end, { nargs = "+" })
