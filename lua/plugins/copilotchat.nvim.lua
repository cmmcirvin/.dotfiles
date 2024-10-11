local plugin = {"CopilotC-Nvim/CopilotChat.nvim"}

plugin.branch = "canary"
plugin.dependencies = {
  { "zbirenbaum/copilot.lua" },
  { "nvim-lua/plenary.nvim" }
}
plugin.build = "make tiktoken"

function plugin.config()
  require("CopilotChat").setup({
    debug = true
  })

  vim.keymap.set({"n", "v", "i"}, "<leader>cc", "<cmd>CopilotChatToggle<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>ce", "<cmd>CopilotChatExplain<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>cr", "<cmd>CopilotChatReview<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>cf", "<cmd>CopilotChatFix<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>co", "<cmd>CopilotChatOptimize<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>cd", "<cmd>CopilotChatDocs<cr>")
  vim.keymap.set({"n", "v", "i"}, "<leader>ct", "<cmd>CopilotChatTests<cr>")
end

return plugin
