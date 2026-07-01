-- yazi.nvim: file manager integration

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'mikavilpas/yazi.nvim' }

require('yazi').setup {
  open_for_directories = true,
}

vim.keymap.set('n', '\\', '<cmd>Yazi<cr>', { desc = 'Yazi file manager' })
