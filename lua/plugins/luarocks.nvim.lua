local plugin = {"vhyrro/luarocks.nvim"}

plugin.priority = 1000
plugin.config = true

plugin.opts = {
  rocks = {"luafilesystem"}
}

return plugin
