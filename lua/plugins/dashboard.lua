local plugin = {"goolord/alpha-nvim"}

plugin.dependencies = {
  {'nvim-tree/nvim-web-devicons'}
}

function plugin.config()
  require("alpha").setup(
    require("alpha.themes.dashboard").config
  )

  --Greeter
  local dashboard = require("alpha.themes.dashboard")
  
  -- Set header
  dashboard.section.header.val = {
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "      ███ █████████████████    █████████████████████  ",
  "     ███                ████   █  █                       █ ", 
  "    ████████     █████████████████████████",
  "   ███████████████████████████████████████",
  "  ████████     ████████████████████████ ",
  " ████ ███     ██  ██████████████████████  ",
  "████   ████████ ████████ ████████████████████   ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  "                                                                      ",
  }                                                                      
                                                                         
  dashboard.section.buttons.val = {
      dashboard.button("o", "   > Recent" , ":Telescope oldfiles<cr>"),
      dashboard.button("f", "   > Find file", ":Telescope find_files<cr>"),
      dashboard.button("e", "   > Explorer", ":Telescope file_browser<cr>"),
      dashboard.button("g", "   > Grep"   , ":Telescope live_grep<cr>"),
      dashboard.button("b", "   > Buffers" , ":Telescope buffers<cr>"),
      dashboard.button("h", "   > Help", ":Telescope help_tags<cr>")
  }

end

return plugin
