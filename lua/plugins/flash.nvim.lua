local plugin = {"folke/flash.nvim"}

plugin.keys = {
  { "s", mode = { "n", "x", "o" },
  function()
    local gi = vim.go.ignorecase
    local gs = vim.go.smartcase
    vim.go.ignorecase = true
    vim.go.smartcase = false
    require("flash").jump()
    vim.go.ignorecase = gi
    vim.go.smartcase = gs
  end, desc = "flash" },
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
