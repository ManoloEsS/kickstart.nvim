-- folke/todo-comments: highlight & search TODOs

vim.pack.add { 'https://github.com/folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<cr>', { desc = '[S]earch [T]odo' })