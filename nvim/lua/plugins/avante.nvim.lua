return {}

-- local plugin = {
--   "yetone/avante.nvim",
--   event = "VeryLazy",
--   lazy = false,
--   version = false,
--   opts = {
--     provider = "gemini",
--     auto_suggestions_provider = "gemini",
--     providers = {
--       gemini = {
--         model = "",
--         max_tokens = 2048,
--       },
--       tavily = {
--         model = "gpt-4o",
--         max_tokens = 2048,
--       },
--     }
--   },
--   web_search_engine = {
--     provider = "tavily",
--   },
--   file_selector = {
--     provider = "telescope",
--   },
--   build = "make",
--   dependencies = {
--     "nvim-treesitter/nvim-treesitter",
--     "nvim-lua/plenary.nvim",
--     "MunifTanjim/nui.nvim",
--     "nvim-tree/nvim-web-devicons",
--     {
--       'MeanderingProgrammer/render-markdown.nvim',
--       opts = {
--         file_types = { "markdown", "Avante" },
--       },
--       ft = { "markdown", "Avante" },
--     },
--   },
-- }
--
-- return plugin

-- Avante.nvim configuration with Gemini models
-- Place this in your Neovim config (e.g., ~/.config/nvim/lua/plugins/avante.lua)

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    -- Provider configuration
    provider = "gemini",

    providers = {
      -- Gemini-specific settings
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash",
        timeout = 30000,
        temperature = 0.7,
        max_tokens = 8192,
      }
    },

    -- Behavior settings
    behaviour = {
      auto_suggestions = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = true,
    },

    -- Window configuration
    windows = {
      wrap = true,
      width = 30, -- percentage or absolute width
      sidebar_header = {
        align = "center",
        rounded = true,
      },
    },

    -- Hints and UI
    hints = { enabled = true },

    -- Diff settings
    diff = {
      autojump = true,
      list_opener = "copen",
    },
  },
  
  -- -- Build step (required for some features)
  -- build = "make",

  -- Dependencies
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },

  -- Additional configuration function
  config = function(_, opts)
    require("avante").setup(opts)

    -- Set up API key from environment variable
    -- Make sure to set GEMINI_API_KEY in your environment
    -- export GEMINI_API_KEY="your-api-key-here"

   -- Optional: Set up autocommands or additional configurations
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "avante",
      callback = function()
        -- Custom settings for Avante buffers
        vim.opt_local.wrap = true
        vim.opt_local.spell = false
      end,
    })
  end,
}
