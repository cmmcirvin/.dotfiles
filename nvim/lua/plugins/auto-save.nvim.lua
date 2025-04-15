local plugin = {"okuuva/auto-save.nvim"}

plugin.event = { "InsertLeave", "TextChanged" }
function plugin.config()
  require("auto-save").setup({
    enabled = true,
    -- trigger_events = {
    --   immediate_save = {
    --     -- Save text after writing characters in insert mode in TeX files
    --     { "TextChangedI", pattern = { "*.tex" } }
    --   }
    -- },
    -- debounce_delay = 0
  })
end

return plugin
