-- autopairs
-- https://github.com/windwp/nvim-autopairs

---@module 'lazy'
---@type LazySpec
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {},
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)

    -- Closing delimiters we commonly want to step past with Ctrl-l (same as one <Right> in insert mode).
    local closers = {
      [')'] = true,
      [']'] = true,
      ['}'] = true,
      ['"'] = true,
      ["'"] = true,
      ['`'] = true,
    }

    vim.keymap.set('i', '<C-l>', function()
      local line = vim.api.nvim_get_current_line()
      local col0 = vim.api.nvim_win_get_cursor(0)[2]
      local next_char = line:sub(col0 + 1, col0 + 1)
      if closers[next_char] then
        return '<Right>'
      end
      return '<Right>'
    end, {
      expr = true,
      replace_keycodes = true,
      desc = 'Jump past closing bracket/quote or move right',
    })

    vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'Move left in insert mode' })
  end,
}
