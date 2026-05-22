-- harpoon: quickly navigate to marked files

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'ThePrimeagen/harpoon', branch = 'harpoon2' } }

local harpoon = require 'harpoon'
local mark = require 'harpoon.mark'
local ui = require 'harpoon.ui'

require('which-key').add { { '<leader>m', group = 'Harpoon' } }

harpoon:setup()

-- Workaround: harpoon2 bug where json_encode fails on function references
-- during BufLeave from snacks explorer/picker windows
local orig_save = harpoon.save
if orig_save then
  harpoon.save = function(...)
    pcall(orig_save, ...)
  end
end

vim.keymap.set('n', '<leader>ma', function() mark.add_file() end, { desc = 'Harpoon [A]dd file' })
vim.keymap.set('n', '<leader>mm', function() ui.toggle_quick_menu() end, { desc = 'Harpoon [M]enu' })
vim.keymap.set('n', '<leader>mh', function() ui.nav_file(1) end, { desc = 'Harpoon file 1' })
vim.keymap.set('n', '<leader>mj', function() ui.nav_file(2) end, { desc = 'Harpoon file 2' })
vim.keymap.set('n', '<leader>mk', function() ui.nav_file(3) end, { desc = 'Harpoon file 3' })
vim.keymap.set('n', '<leader>ml', function() ui.nav_file(4) end, { desc = 'Harpoon file 4' })

-- Alt+hjkl to navigate harpoon files 1-4
vim.keymap.set('n', '<M-h>', function() ui.nav_file(1) end, { desc = 'Harpoon file 1' })
vim.keymap.set('n', '<M-j>', function() ui.nav_file(2) end, { desc = 'Harpoon file 2' })
vim.keymap.set('n', '<M-k>', function() ui.nav_file(3) end, { desc = 'Harpoon file 3' })
vim.keymap.set('n', '<M-l>', function() ui.nav_file(4) end, { desc = 'Harpoon file 4' })