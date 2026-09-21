-- Render Markdown with visual wrapping, without changing the file's line breaks.

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'MeanderingProgrammer/render-markdown.nvim' }

require('render-markdown').setup {
  preset = 'lazy',
  file_types = { 'markdown' },
  code = {
    sign = false,
    width = 'block',
    right_pad = 1,
  },
  heading = {
    sign = false,
    icons = {},
  },
  overrides = {
    buftype = {
      nofile = {
        code = {
          disable_background = true,
          highlight_border = false,
        },
      },
    },
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function(args)
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.showbreak = '  '
    vim.opt_local.textwidth = 0
    vim.opt_local.wrapmargin = 0

    vim.keymap.set('n', '<leader>um', '<cmd>RenderMarkdown toggle<CR>', {
      buffer = args.buf,
      desc = 'Toggle Markdown rendering',
    })
  end,
})
