-- mbbill/undotree: visual undo history browser

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'mbbill/undotree' }

vim.keymap.set('n', '<leader>ut', '<cmd>UndotreeToggle<CR>', { desc = 'Undotree' })