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
return plugin
