if not os.getenv("IN_LOCAL_SHELL") then
  return {}
end

local plugin = {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
  },
  web_search_engine = {
    provider = "tavily",
  },
  file_selector = {
    provider = "telescope",
  },
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    -- "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}

return plugin
