-- smear-cursor.nvim: animated cursor movement

local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'sphamba/smear-cursor.nvim' }

require('smear_cursor').setup {
  smear_between_buffers = true,
  smear_between_neighbor_lines = true,
  scroll_buffer_space = true,
  legacy_computing_symbols_support = true,
  smear_insert_mode = true,

  -- Transparent background: TokyoNight storm has no opaque bg, so the smear
  -- rendering can leave a shadow. This fallback color eliminates it.
  transparent_bg_fallback_color = '#24283b',

  -- Slightly snappier than defaults (matches your 50ms updatetime)
  stiffness = 0.8,
  trailing_stiffness = 0.6,
  stiffness_insert_mode = 0.7,
  trailing_stiffness_insert_mode = 0.7,
  damping = 0.95,
  damping_insert_mode = 0.95,
  distance_stop_animating = 0.5,

  -- Prevent ghost cursor artifacts when using transparent backgrounds
  hide_target_hack = true,
  never_draw_over_target = true,
}
