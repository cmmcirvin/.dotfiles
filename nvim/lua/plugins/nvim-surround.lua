local plugin = {"kylechui/nvim-surround"}

plugin.event = 'VeryLazy'

function plugin.config()
  require("nvim-surround").setup {
    surrounds = {
      ["c"] = {
        add = function()
          local cmd = require("nvim-surround.config").get_input "Command: "
          if cmd == "bf" then
            cmd = "textbf"
          elseif cmd == "it" then
            cmd = "textit"
          elseif cmd == "cm" then
            cmd = "cmnote"
          end
          return { { "\\" .. cmd .. "{" }, { "}" } }
        end,
      },
      ["e"] = {
        add = function()
          local env = require("nvim-surround.config").get_input "Environment: "
          return { { "\\begin{" .. env .. "}" }, { "\\end{" .. env .. "}" } }
        end,
      }
    },
    keymaps = {
      normal_cur = "yS"
    },
    aliases = {
      ["a"] = "}",
      ["p"] = ")",
      ["b"] = "*",
      ["u"] = "_",
      ["x"] = "~",
      ["c"] = "`",
      ["B"] = ">"
    }
  }
end

return plugin
