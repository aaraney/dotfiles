local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
    override_builtin = true,
}

vim.keymap.set({ 'i', 's' }, '<c-k>', function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

vim.keymap.set("i", "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

local snippets = {
    python = {
        s("main", fmt([[
        from __future__ import annotations


        def main() -> None:
            {}


        if __name__ == "__main__":
            main()
        ]], { i(1) })),
        s("ipd", { t("import pandas as pd") }),
        s("inp", { t("import numpy as np") }),
    },
    go = {
        s("ie", fmt([[
        if err != nil{{
            {}
        }}
        ]], { i(1) })),
        s("test", fmt([[
        func Test{}(t *testing.T){{
            {}
        }}
        ]], { i(1), i(0) }
        ))
    }
}

for lang, snips in pairs(snippets) do
    require("luasnip.session.snippet_collection").clear_snippets(lang)
    ls.add_snippets(lang, snips)
end
