if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {"rmagatti/auto-session"}

function plugin.config()
  vim.keymap.set("n", "<leader>ss", "<cmd>SessionSave<cr>")

  require("auto-session").setup({
    auto_session_suppress_dirs = { "~/", "~/Documents", "~/Downloads", "/" },
    auto_session_create_enabled = false,
  })
end

return plugin
