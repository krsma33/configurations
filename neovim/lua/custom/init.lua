local opt = vim.opt

opt.relativenumber = true

vim.cmd([[
  set shell=pwsh
  set shellcmdflag=-command
  set shellquote=\"
  set shellxquote=
]])

-- Close quicfix menu after selecting choice
vim.api.nvim_create_autocmd(
  "FileType", {
  pattern={"qf"},
  command=[[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
})
