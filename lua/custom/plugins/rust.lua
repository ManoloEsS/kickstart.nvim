vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
    },
  },
})
vim.lsp.enable('rust_analyzer')

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.rs',
  group = vim.api.nvim_create_augroup('rust', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_clients({ name = 'rust_analyzer', bufnr = args.buf })[1]
    if not client then return end

    local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
    params.context = { only = { 'source.organizeImports' } }

    local result = client.request_sync('textDocument/codeAction', params, 1000)
    if result and result.result and result.result[1] and result.result[1].edit then
      vim.lsp.util.apply_workspace_edit(result.result[1].edit, client.offset_encoding)
    end
  end,
})
