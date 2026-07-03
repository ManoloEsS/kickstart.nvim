-- yazi.nvim: file manager integration

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'mikavilpas/yazi.nvim' }

-- Disable netrw early so it doesn't load before yazi's hijack
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('yazi').setup {
  open_for_directories = true,
}

vim.keymap.set('n', '\\', '<cmd>Yazi<cr>', { desc = 'Yazi file manager' })
