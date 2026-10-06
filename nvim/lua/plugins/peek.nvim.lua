if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = { "toppair/peek.nvim" }

plugin.event = { "VeryLazy" }
plugin.build = "deno task --quiet build:fast"
plugin.config = function()
    local peek = require("peek")
    peek.setup({
      theme = "light",
      app = "browser"
    })
    vim.api.nvim_create_user_command("PeekOpen", peek.open, {})
    vim.api.nvim_create_user_command("PeekClose", peek.close, {})
    vim.keymap.set("n", "<C-p>", function()
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end, { desc = "Toggle Peek" })
end

return plugin
