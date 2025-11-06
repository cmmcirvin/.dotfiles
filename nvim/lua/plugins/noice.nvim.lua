plugin = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- -- OPTIONAL:
    -- --   `nvim-notify` is only needed, if you want to use the notification view.
    -- --   If not available, we use `mini` as the fallback
    -- "rcarriga/nvim-notify",
    }
}

function plugin.config()
  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    views = {
      cmdline_popup = {
        position = {
          row = "95%",
          col = "50%",
        },
      }
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
  })

  -- Apply Rose Pine colors to Noice command line / popup
  local rp = require("rose-pine.palette")

  vim.api.nvim_set_hl(0, "NoiceCmdline",         { fg = rp.gold,  bg = rp.base })
  vim.api.nvim_set_hl(0, "NoiceCmdlineIcon",     { fg = rp.love,  bg = rp.base })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopup",    { fg = rp.text,  bg = rp.base })
  vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", { fg = rp.gold, bg = rp.base })

end

return plugin
