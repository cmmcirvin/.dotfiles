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

local marathon_plan = {
  { start = { year=2026, month=6,  day=15 }, days = { "3 mi", "Rest", "4 mi", "Rest", "3 mi",  "9 mi",  "Rest"     } },
  { start = { year=2026, month=6,  day=22 }, days = { "3 mi", "Rest", "5 mi", "Rest", "3 mi",  "10 mi", "Rest"     } },
  { start = { year=2026, month=6,  day=29 }, days = { "3 mi", "Rest", "5 mi", "Rest", "3 mi",  "7 mi",  "Rest"     } },
  { start = { year=2026, month=7,  day=6  }, days = { "3 mi", "Rest", "6 mi", "Rest", "3 mi",  "12 mi", "Rest"     } },
  { start = { year=2026, month=7,  day=13 }, days = { "3 mi", "Rest", "6 mi", "Rest", "3 mi",  "13 mi", "Rest"     } },
  { start = { year=2026, month=7,  day=20 }, days = { "3 mi", "Rest", "7 mi", "Rest", "4 mi",  "10 mi", "Rest"     } },
  { start = { year=2026, month=7,  day=27 }, days = { "3 mi", "Rest", "7 mi", "Rest", "4 mi",  "15 mi", "Rest"     } },
  { start = { year=2026, month=8,  day=3  }, days = { "4 mi", "Rest", "8 mi", "Rest", "4 mi",  "16 mi", "Rest"     } },
  { start = { year=2026, month=8,  day=10 }, days = { "4 mi", "Rest", "8 mi", "Rest", "5 mi",  "12 mi", "Rest"     } },
  { start = { year=2026, month=8,  day=17 }, days = { "4 mi", "Rest", "9 mi", "Rest", "5 mi",  "18 mi", "Rest"     } },
  { start = { year=2026, month=8,  day=24 }, days = { "5 mi", "Rest", "9 mi", "Rest", "5 mi",  "14 mi", "Rest"     } },
  { start = { year=2026, month=8,  day=31 }, days = { "5 mi", "Rest", "10 mi","Rest", "5 mi",  "20 mi", "Rest"     } },
  { start = { year=2026, month=9,  day=7  }, days = { "5 mi", "Rest", "8 mi", "Rest", "4 mi",  "12 mi", "Rest"     } },
  { start = { year=2026, month=9,  day=14 }, days = { "4 mi", "Rest", "6 mi", "Rest", "3 mi",  "8 mi",  "Rest"     } },
  { start = { year=2026, month=9,  day=21 }, days = { "3 mi", "Rest", "4 mi", "Rest", "2 mi",  "Rest",  "Marathon" } },
}

-- Returns the training entry for a given os.time timestamp, or nil if outside plan.
local function get_marathon_training_for_day(t)
  -- Normalize t to midnight
  local d = os.date("*t", t)
  local target = os.time({ year=d.year, month=d.month, day=d.day, hour=0, min=0, sec=0 })
 
  for _, week in ipairs(marathon_plan) do
    local week_start = os.time({ year=week.start.year, month=week.start.month, day=week.start.day, hour=0, min=0, sec=0 })
    local week_end   = week_start + 6 * 86400
    if target >= week_start and target <= week_end then
      -- day index: 0=Mon ... 6=Sun
      local day_idx = math.floor((target - week_start) / 86400) + 1
      return week.days[day_idx]
    end
  end
  return nil
end


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
      "- [ ] 2 minutes plank",
      "- [ ] 50 pushups",
      "- [ ] Read Bible",
    }),
    f(function()
      local wday = os.date("*t", os.time() + 86400).wday
      if wday == 3 or wday == 5 then
        return { "", "- [ ] Climbing" }
      end
      return { "" }
    end),
    f(function()
      local wday = os.date("*t", os.time() + 86400).wday
      if wday == 2 or wday == 3 or wday == 5 then
        return { "", "- [ ] Gym" }
      end
      return { "" }
    end),
    f(function()
      local tomorrow = os.time() + 86400
      local entry = get_marathon_training_for_day(tomorrow)
      if entry and entry ~= "Rest" then
        return { "", "- [ ] Ran " .. entry }
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
