local plugin = {'nvim-treesitter/nvim-treesitter', branch='main'}

plugin.dependencies = {
  {'nvim-tree/nvim-web-devicons'}
}

function plugin.config()
  require('nvim-treesitter').setup {}

  local disabled_ft = os.getenv("NVIM_TREESITTER_DISABLED") or ""
  local disabled_filetypes = vim.split(disabled_ft, ",", { trimempty = true })

  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
      if ft ~= '' and not vim.tbl_contains(disabled_filetypes, ft) then
        pcall(vim.treesitter.start, args.buf)
      end
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

return plugin
