-- snacks.nvim: UI utilities suite

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'folke/snacks.nvim' }

require('snacks').setup {
  bigfile = { enabled = false },
  dashboard = { enabled = false },
  explorer = {
    enabled = true,
    replace_netrw = true,
  },
  indent = { enabled = false },
  input = { enabled = false },
  notifier = { enabled = false },
  picker = {
    enabled = false,
    sources = {
      explorer = {
        auto_close = true,
        layout = {
          { preview = true },
          layout = {
            box = 'horizontal',
            width = 0.8,
            height = 0.8,
            {
              box = 'vertical',
              border = 'rounded',
              title = '{source} {live} {flags}',
              title_pos = 'center',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
            },
            { win = 'preview', border = 'rounded', width = 0.8, title = '{preview}' },
          },
        },
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = false },
  scroll = { enabled = true },
  statuscolumn = { enabled = false },
  words = { enabled = true },
  styles = {
    notification = {},
  },
}

-- ============================================================
-- Keymaps
-- ============================================================

-- Explorer
vim.keymap.set('n', '<leader>e', function()
  Snacks.explorer()
end, { desc = 'File Explorer' })

-- Git
vim.keymap.set('n', '<leader>gg', function()
  Snacks.lazygit()
end, { desc = 'Lazygit' })

vim.keymap.set({ 'n', 'v' }, '<leader>gB', function()
  Snacks.gitbrowse()
end, { desc = 'Git Browse' })

-- Undo
vim.keymap.set('n', '<leader>su', function()
  Snacks.picker.undo()
end, { desc = 'Undo History' })

-- File rename
vim.keymap.set('n', '<leader>cR', function()
  Snacks.rename.rename_file()
end, { desc = 'Rename File' })

-- Neovim News
vim.keymap.set('n', '<leader>N', function()
  Snacks.win {
    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
    width = 0.6,
    height = 0.6,
    wo = {
      spell = false,
      wrap = false,
      signcolumn = 'yes',
      statuscolumn = ' ',
      conceallevel = 3,
    },
  }
end, { desc = 'Neovim News' })

-- Words navigation
vim.keymap.set({ 'n', 't' }, ']]', function()
  Snacks.words.jump(vim.v.count1)
end, { desc = 'Next Reference' })

vim.keymap.set({ 'n', 't' }, '[[', function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = 'Prev Reference' })

-- ============================================================
-- Toggles (set up on VeryLazy)
-- ============================================================

vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
    Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
    Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
    Snacks.toggle.diagnostics():map('<leader>ud')
    Snacks.toggle.line_number():map('<leader>ul')
    Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
    Snacks.toggle.treesitter():map('<leader>uT')
    Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
    Snacks.toggle.inlay_hints():map('<leader>uh')
    Snacks.toggle.indent():map('<leader>ug')
    Snacks.toggle.dim():map('<leader>uD')
  end,
})
