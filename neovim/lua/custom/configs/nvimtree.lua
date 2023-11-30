local M = {}

M.opts = {
  view = {
    width = 45,
  },
  filters = {
    git_ignored = true,
    dotfiles = true,
    -- custom = {
    --   "bin",
    --   "obj",
    -- },
    exclude = {
      vim.fn.stdpath "config" .. "\\lua\\custom",
      ".gitignore",
    },
  },
  git = {
    enable = true,
  },
}

return M
