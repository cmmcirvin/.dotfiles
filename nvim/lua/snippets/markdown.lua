local ls = require("luasnip")
local ce = require("luasnip.extras.conditions.expand")
local lb = ce.line_begin

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local f = ls.function_node


return {
  s({ trig = "tmw",
    desc = "Tomorrow checklist",
    snippetType = "autosnippet",
    wordTrig = true,
    condition = lb,
  }, {
    f(function()
      return os.date("# %m/%d/%Y", os.time() + 86400)
    end),
    t({
      "",
      "- [ ] Stretched",
      "- [ ] Bible: ",
    }),
    f(function()
      local day = tonumber(os.date("%j", os.time() + 86400))
      local handle = io.popen("awk -F',' 'NR==" .. day + 1 .. "' ~/personal/scripture_reading_plan_2026.csv")
      local line = handle:read("*l")
      handle:close()

      if not line then
        return ""
      end

      local fields = {}
      local pos = 1
      while true do
        local sep = line:find(",", pos)
        if not sep then
          table.insert(fields, line:sub(pos))
          break
        end
        table.insert(fields, line:sub(pos, sep - 1))
        pos = sep + 1
      end

      local verses = {}
      for i = 3, #fields do
        if fields[i] and fields[i] ~= "" then
          table.insert(verses, fields[i])
        end
      end

      return table.concat(verses, " / ")
    end),

    f(function()
      local wday = os.date("*t", os.time() + 86400).wday
      if wday == 3 or wday == 5 then
        return { "", "- [ ] Climbing" }
      end
      return { "" }
    end),
    f(function()
      local wday = os.date("*t", os.time() + 86400).wday
      if wday == 2 or wday == 6 then
        return { "", "- [ ] Gym" }
      end
      return { "" }
    end),
    t({
      "",
      "- [ ] Cleared Anki",
      "- [ ] Work",
    }),
  }),
  s({ trig = "hl", snippetType = "autosnippet" }, {
      t("---"),
    }),
  -- Code block (generic)
  s({ trig = "cb", snippetType = "autosnippet", condition = lb }, {
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
  s({ trig = "dl", condition = lb }, {
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
  s({ trig = "cd", snippetType = "autosnippet", condition = lb }, {
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
  s({ trig = "sec", snippetType = "autosnippet", condition = lb }, {
      t("# "),
      i(1, "Section Name"),
    }),
  s({ trig = "sub", snippetType = "autosnippet", condition = lb }, {
      t("## "),
      i(1, "Section Name"),
    }),
  s({ trig = "sbb", snippetType = "autosnippet", condition = lb }, {
      t("### "),
      i(1, "Section Name"),
    }),
  s({ trig = "par", snippetType = "autosnippet", condition = lb }, {
      t("#### "),
      i(1),
    }),
  s({ trig = "spar", snippetType = "autosnippet", condition = lb }, {
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
  s({ trig = "eqn", snippetType = "autosnippet", condition = lb }, {
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
  s({ trig = "ak", snippetType = "autosnippet", condition = lb }, {
      t("> **_"),
      i(1, "NOTE:"),
      t("_** <br>"),
      t({ "", "" }),
      i(2),
      t("<br>"),
      i(0),
    }),
  -- cloze-style block
  s({ trig = "clz", snippetType = "autosnippet", condition = lb }, {
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
      condition = lb,
    }, {
      t("- [ ] "),
      i(1),
    }),
}
