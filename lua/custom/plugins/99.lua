-- ThePrimeagen/99: AI assistant integration

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add { gh 'ThePrimeagen/99' }

local _99 = require '99'
local cwd = vim.uv.cwd()
local basename = vim.fs.basename(cwd)

_99.setup {
  provider = _99.Providers.OpenCodeProvider,
  model = 'opencode-go/qwen3.5-plus',
  logger = {
    level = _99.DEBUG,
    path = '/tmp/' .. basename .. '.99.debug',
    print_on_error = true,
  },
  md_files = {
    'AGENT.md',
    'SKILL.md',
  },
}

vim.keymap.set('n', '<leader>9s', function()
  _99.search()
end, { desc = '[9]9 Search' })

vim.keymap.set('v', '<leader>9vd', function()
  _99.set_model('opencode-go/qwen3.5-plus')
  _99.visual()
end, { desc = '[9]9 Visual [d]efault (qwen3.5-plus)' })

vim.keymap.set('v', '<leader>9vf', function()
  _99.set_model('opencode-go/mimo-v2-pro')
  _99.visual()
end, { desc = '[9]9 Visual [f]ast (mimo-v2-pro)' })
