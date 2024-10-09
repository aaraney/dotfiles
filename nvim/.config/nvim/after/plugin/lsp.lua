require('mason-tool-installer').setup {
    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
        'prettierd',
        'ruff',
    },
    auto_update = true,
    debounce_hours = 24,
}


-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>r', vim.lsp.buf.rename, '[R]ename')
    nmap('<leader>a', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('<M-u>', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>o', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>O', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')


    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- vscode like remap for completion
    vim.keymap.set('i', '<C-.>', vim.lsp.buf.completion, { buffer = bufnr })

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    nmap("<leader>f", function()
        vim.lsp.buf.format()
        vim.cmd(":Format")
    end)
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
    -- clangd = {},
    gopls = {},
    pyright = {
        python = {
            -- all options: https://microsoft.github.io/pyright/#/settings
            -- default settings: https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/pyright.lua
            -- analysis = {
            --     typeCheckingMode = 'strict',
            -- },
        },
    },
    ruff = {},
    rust_analyzer = {},
    tsserver = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

local handlers = {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
        }
    end,
    -- Next, you can provide targeted overrides for specific servers.
    ["pyright"] = function()
        local test_py_mod = function()
            local filepath = vim.api.nvim_buf_get_name(0)
            local parts = vim.split(filepath, "/")
            local filename = parts[#parts]
            -- TODO: check if nil
            if not vim.startswith(filename, "test") then
                return
            end

            -- :terminal instead to retain colors
            local buff_id = vim.api.nvim_create_buf(false, true)
            local width   = vim.api.nvim_win_get_width(0)
            local height  = vim.api.nvim_win_get_height(0)

            local col     = math.floor(width * 0.1)
            local row     = math.floor(height * 0.1)

            vim.api.nvim_open_win(
                buff_id,
                true,
                {
                    relative = 'win',
                    col = col,
                    row = row,
                    width = math.floor(width * 0.8),
                    height = math.floor(height *
                        0.8),
                    border = "rounded",
                }
            )
            -- run tests
            vim.fn.termopen("pytest -s " .. filepath)

            vim.api.nvim_buf_set_keymap(buff_id, "n", "q", ":bd<CR>", {})
        end

        local pyright_on_attach = function(_, bufnr)
            vim.keymap.set('n', '<leader>t', test_py_mod, { buffer = bufnr })
            on_attach(_, bufnr)
        end

        vim.lsp.set_log_level("debug")
        require("lspconfig")["pyright"].setup {
            capabilities = capabilities,
            on_attach = pyright_on_attach,
            settings = servers["pyright"],
        }
    end,
}

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    handlers = handlers,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        -- maybe turn this into a command so that you can toggle it on and off?
        -- {
        --     name = 'spell',
        --     option = {
        --         keep_all_entries = false,
        --         enable_in_context = function()
        --             return true
        --         end,
        --     },
        -- },
    },
}
