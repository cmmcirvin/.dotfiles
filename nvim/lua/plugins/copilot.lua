local plugin = {"zbirenbaum/copilot.lua"}

plugin.dependencies = {
  "copilotlsp-nvim/copilot-lsp",
  init = function()
    vim.g.copilot_nes_debounce = 500
  end,
}

function plugin.config()
  require("copilot").setup({
    cmd = "Copilot",
    event = "InsertEnter",
    nes = {
      enabled = true,
      keymap = {
        accept_and_goto = "<leader>p",
        accept = false,
        dismiss = "<Esc>",
      }
    }
  })
end

return plugin
