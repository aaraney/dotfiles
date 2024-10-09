-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
    filetype = {
        javascriptreact = { require 'formatter.defaults.prettierd' },
        javascript = { require 'formatter.defaults.prettierd' },
        typescriptreact = { require 'formatter.defaults.prettierd' },
        typescript = { require 'formatter.defaults.prettierd' },
        markdown = { require 'formatter.defaults.prettierd' },
        json = { require 'formatter.defaults.prettierd' },
        yaml = { require 'formatter.defaults.prettierd' },
        html = { require 'formatter.defaults.prettierd' },
        css = { require 'formatter.defaults.prettierd' },
        -- lua-language-server takes care of formatting lua files
        ["*"] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
            require("formatter.filetypes.any").remove_trailing_whitespace
        }
    }
}
