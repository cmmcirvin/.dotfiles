local plugin = {'cmmcirvin/anki.nvim'}

plugin.opts = {
    {
      tex_support = false,
      models = {
        NoteType = "Default",
        ["Basic"] = "Default",
      },
    }
  }

plugin.config = function()
  require("anki").setup({
    enabled = os.getenv("ANKI_NVIM_ENABLED") == "true",
  })
end
return plugin
