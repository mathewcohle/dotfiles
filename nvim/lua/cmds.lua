vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <C-v> <C-w><Enter><C-w>L]]})
