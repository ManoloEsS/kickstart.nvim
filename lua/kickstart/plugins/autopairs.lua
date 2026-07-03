-- autopairs
-- https://github.com/windwp/nvim-autopairs

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}

-- Don't auto-insert } inside org #+BEGIN_SRC / #+END_SRC blocks
-- Avoids conflict with orgmode's indent/format machinery
local rule = require('nvim-autopairs').get_rule('{')
if rule then
  rule:with_pair(function(opts)
    if vim.bo[opts.bufnr].filetype ~= 'org' then return true end
    local node = vim.treesitter.get_node()
    while node do
      if node:type() == 'block' then return false end
      node = node:parent()
    end
    return true
  end)
end
