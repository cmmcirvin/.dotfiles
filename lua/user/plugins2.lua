vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  command = "setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2"
})
