local plugin = {"folke/flash.nvim"}

plugin.keys = {
  { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "flash" },
  { "f", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "flash treesitter" },
  { "r", mode = "o", function() require("flash").remote() end, desc = "remote flash" }
}

function plugin.config()
  require("flash").setup({
    modes = {
      char = { enabled = false, keys = {} }
    }
  })
end

return plugin
