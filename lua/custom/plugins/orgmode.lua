local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'nvim-orgmode/orgmode',
  gh 'nvim-orgmode/org-bullets.nvim',
  gh 'nvim-orgmode/telescope-orgmode.nvim',
}

require('orgmode').setup {
  org_agenda_files = '~/org/**/*',
  org_default_notes_file = '~/org/refile.org',
  org_capture_templates = {
    d = {
      description = 'Dev journal entry',
      template = '**** %^{Topic}\n***** %U %?',
      target = '~/org/dev-journal.org',
      datetree = true,
    },
  },
  org_babel_default_header_args = {
    [':tangle'] = 'no',
    [':noweb'] = 'no',
  },
  org_edit_src_filetype_map = {
    -- sh = 'bash',
  },
}

require('org-bullets').setup()

vim.lsp.enable('org')

pcall(require('telescope').load_extension, 'orgmode')
