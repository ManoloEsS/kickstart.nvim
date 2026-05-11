-- Core settings, keymaps, autocommands, and highlights migrated from kickstartmanolo

-- ============================================================
-- Options
-- ============================================================

vim.o.list = true
vim.opt.listchars = {
  tab = '│ ',
  trail = '·',
  nbsp = '␣',
  leadmultispace = '│   ',
}

vim.o.nu = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.swapfile = false
vim.o.backup = false
vim.o.termguicolors = true
vim.opt.isfname:append '@-@'
vim.opt.autoread = true

-- Add rounded borders to all floating windows (hover, signature help, diagnostics, etc.)
vim.o.winborder = 'rounded'

-- ============================================================
-- Keymaps
-- ============================================================

-- Visual mode: move selected lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = '[M]ove line down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = '[M]ove line up' })

-- Normal mode: join lines keeping cursor position
vim.keymap.set('n', 'J', 'mzJ`z', { desc = '[J]oin lines' })

-- Centered scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = '[D]own half page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = '[U]p half page' })

-- Centered search navigation
vim.keymap.set('n', 'n', 'nzzzv', { desc = '[N]ext search result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = '[-]rev search result' })

-- Format paragraph
vim.keymap.set('n', '=ap', "ma=ap'a", { desc = '[A]uto [P]aragraph' })

-- Clipboard & black hole registers
vim.keymap.set('x', '<leader>p', [['_dP]], { desc = '[P]aste from black hole' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = '[Y]ank to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = '[Y]ank line to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"_d', { desc = '[D]elete to black hole' })

-- Location list navigation
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz', { desc = '[K]ext location' })
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz', { desc = '[J]rev location' })

-- Terminal mode exit
vim.keymap.set('t', '<C-a>', '<C-\\><C-n>', { desc = '[E]xit terminal' })

-- Replace all occurrences of word under cursor
vim.keymap.set('n', '<leader>a', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gIc<Left><Left><Left><Left>]], { desc = '[A]ll in file' })

-- Snippet navigation (blink.cmp)
vim.keymap.set({ 'i', 's' }, '<C-.>', function()
  require('blink.cmp').snippet_forward()
end, { desc = 'Snippet forward' })

vim.keymap.set({ 'i', 's' }, '<C-,>', function()
  require('blink.cmp').snippet_backward()
end, { desc = 'Snippet backward' })

-- Equalize splits
vim.keymap.set('n', '<leader>w', '<C-w>=', { desc = 'Make equal splits' })

-- Load all files with same extension into args
vim.keymap.set('n', '<leader>ra', function()
  local ext = vim.fn.expand '%:e'
  local current_file = vim.fn.expand '%:p'
  local view = vim.fn.winsaveview()

  local files = vim.fn.systemlist(string.format('find . -name "*.%s" -type f', ext))
  vim.cmd('args ' .. table.concat(files, ' '))

  vim.cmd('edit ' .. vim.fn.fnameescape(current_file))
  vim.fn.winrestview(view)

  print(string.format('Loaded %d .%s files into args', #files, ext))
end, { desc = 'Load all files with same extension into args' })

-- Replace word under cursor across all arg files
vim.keymap.set('n', '<leader>rp', function()
  vim.fn.setreg('/', '\\<' .. vim.fn.expand '<cword>' .. '\\>')
  vim.cmd 'set hlsearch'

  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(
      [[:argdo %s/\<<C-r><C-w>\>//gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]],
      true,
      false,
      true
    ),
    'n',
    false
  )
end, { desc = 'Replace word under cursor in args' })

-- ============================================================
-- Go Autocommands
-- ============================================================

local go_group = vim.api.nvim_create_augroup('GoAutoImport', { clear = true })

vim.api.nvim_create_autocmd('BufWritePre', {
  group = go_group,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format { async = false }
    vim.lsp.buf.code_action {
      context = { only = { 'source.organizeImports' } },
      apply = true,
    }
  end,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  group = go_group,
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action {
      context = { only = { 'source.organizeImports' } },
      apply = true,
    }
  end,
})

-- ============================================================
-- Highlights
-- ============================================================

vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
vim.api.nvim_set_hl(0, 'PmenuSel', { bg = 'none', blend = 10 })

-- ============================================================
-- Transparency & Theme Overrides
-- ============================================================

-- Re-apply tokyonight with transparency settings
require('tokyonight').setup {
  transparent = true,
  styles = {
    comments = { italic = false },
    floats = 'transparent',
    sidebars = 'transparent',
  },
}
vim.cmd.colorscheme 'tokyonight'

-- NOTE: blink.cmp border overrides (menu = 'none', signature = 'none')
-- are now set directly in init.lua to avoid double-setup issues.
