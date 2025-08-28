local plugin = {"windwp/nvim-autopairs"}

plugin.event = "InsertEnter"
plugin.config = function()
  require('nvim-autopairs').setup({
    check_ts = true,
    fast_wrap = {
      map = '<leader>e',
      chars = { '{', '[', '(', '"', "'" },  -- Characters to wrap
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),  -- Pattern for wrapping
      offset = 0,  -- Offset for the cursor position
      end_key = '$',  -- Key to end the wrapping
      keys = 'qwertyuiopzxcvbnmasdfghjkl',  -- Keys for fast wrap
      highlight = 'Search',  -- Highlight group for the wrapped text
    },
  })
end

return plugin
