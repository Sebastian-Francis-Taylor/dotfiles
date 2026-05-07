local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local postfix = require("luasnip.extras.postfix").postfix
local l = require("luasnip.extras").lambda

ls.add_snippets("typst", {
    postfix(".h", fmt("hat(<>)", { l(l.POSTFIX_MATCH) })),
    postfix(".t", fmt("tilde(<>)", { l(l.POSTFIX_MATCH) })),
    postfix(".b", fmt("bar(<>)", { l(l.POSTFIX_MATCH) })),
})
