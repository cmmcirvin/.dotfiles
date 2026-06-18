local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local f = ls.function_node

return {
  -- Tomorrow checklist (UltiSnips Python eval converted)
  s({
      trig = "tmw",
      desc = "Tomorrow checklist",
      snippetType = "autosnippet",
      wordTrig = true,
    }, {
      f(function()
        return os.date("%m/%d/%Y", os.time() + 86400)
      end),
      t({
        "",
        "- [ ] Cleared Anki",
        "- [ ] Added to Anki",
        "- [ ] Gym",
      }),
    }),
  -- Horizontal line
  s({ trig = "hl", snippetType = "autosnippet" }, {
      t("---"),
    }),
  -- Code block (generic)
  s({ trig = "cb", snippetType = "autosnippet" }, {
      t("```"),
      i(1, "py"),
      t({ "", "" }),
      i(2),
      t({ "", "```", "" }),
      i(0),
    }),
  -- Footnote
  s({ trig = "fnt", snippetType = "autosnippet" }, {
      t("[^"),
      i(1, "Footnote"),
      t("]"),
      i(0),
      t({
        "",
        "",
        "[^",
      }),
      i(1),
      t("]: "),
      i(2, "Text"),
    }),
  -- Disclosure
  s({ trig = "dl" }, {
      t({
        "<details open=\"\">",
        "  <summary>",
      }),
      i(1),
      t({
        "</summary>",
        "  ",
      }),
      i(2),
      t({
        "",
        "</details>",
      }),
      i(0),
    }),
  -- Link
  s({
      trig = "lnk",
      priority = 1000,
      snippetType = "autosnippet",
    }, {
      t("["),
      i(1),
      t("]("),
      i(2, "link"),
      t(")"),
      i(0),
    }),
  -- Code block (python)
  s({ trig = "cd", snippetType = "autosnippet" }, {
      t("```python"),
      t({ "", "" }),
      i(1),
      t({ "", "```", "" }),
      i(0),
    }),
  -- Horizontal code block (updated mc variant ignored earlier)
  s({ trig = "bk", snippetType = "autosnippet" }, {
      t("<br>"),
      i(0),
    }),
  -- Section headers
  s({ trig = "sec", snippetType = "autosnippet" }, {
      t("# "),
      i(1, "Section Name"),
    }),
  s({ trig = "sub", snippetType = "autosnippet" }, {
      t("## "),
      i(1, "Section Name"),
    }),
  s({ trig = "sbb", snippetType = "autosnippet" }, {
      t("### "),
      i(1, "Section Name"),
    }),
  s({ trig = "par", snippetType = "autosnippet" }, {
      t("#### "),
      i(1),
    }),
  s({ trig = "spar", snippetType = "autosnippet" }, {
      t("##### "),
      i(1),
    }),
  -- Formatting
  s({ trig = "bf", snippetType = "autosnippet" }, {
      t("**"),
      i(1),
      t("**"),
      i(2),
    }),
  s({ trig = "itl", snippetType = "autosnippet" }, {
      t("_"),
      i(1),
      t("_"),
      i(2),
    }),
  -- Equation block
  s({ trig = "eqn", snippetType = "autosnippet" }, {
      t({ "$$", "" }),
      i(1),
      t({ "", "$$", "" }),
      i(0),
    }),
  -- Markdown break
  s({ trig = "bk", snippetType = "autosnippet" }, {
      t("<br>"),
      i(0),
    }),
  -- Anki card
  s({ trig = "ak", snippetType = "autosnippet" }, {
      t("> **_"),
      i(1, "NOTE:"),
      t("_** <br>"),
      t({ "", "" }),
      i(2),
      t("<br>"),
      i(0),
    }),
  -- cloze-style block
  s({ trig = "clz", snippetType = "autosnippet" }, {
      t("> "),
      i(1),
      t({ "", "" }),
      i(0),
    }),
  -- Checklist (your original ckls)
  s({
      trig = "ckls",
      snippetType = "autosnippet",
      wordTrig = false,
    }, {
      t("- [ ] "),
      i(1),
    }),
}
