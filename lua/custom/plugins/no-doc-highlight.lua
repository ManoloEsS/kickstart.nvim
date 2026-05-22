-- Disable LSP document highlight (highlight all instances of word under cursor)
-- Keeps updatetime=50 for fast diagnostic floats, but removes the visual highlight
vim.lsp.buf.document_highlight = function() end

