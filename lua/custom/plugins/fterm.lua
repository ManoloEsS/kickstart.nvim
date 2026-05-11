-- FTerm.nvim: floating terminal

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'numToStr/FTerm.nvim' }

local fterm = require 'FTerm'
local custom_term = fterm:new {
  ft = 'fterm_custom',
  cmd = vim.o.shell,
  dimensions = {
    height = 0.6,
    width = 0.5,
    x = 0.95,
    y = 0.95,
  },
  border = 'rounded',
}

function _G.__fterm_custom_toggle()
  custom_term:toggle()
end

vim.keymap.set('n', '<C-t>', '<CMD>lua __fterm_custom_toggle()<CR>', { desc = '[T]oggle [T]erminal' })
vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua __fterm_custom_toggle()<CR>', { desc = '[T]oggle [T]erminal' })
