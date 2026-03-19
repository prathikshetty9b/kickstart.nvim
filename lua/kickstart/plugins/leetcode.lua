-- leetcode.nvim
-- https://github.com/kawre/leetcode.nvim

---@module 'lazy'
---@type LazySpec
return {
  'kawre/leetcode.nvim',
  cmd = 'Leet',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    lang = 'cpp',
    picker = { provider = 'telescope' },
    plugins = {
      non_standalone = true,
    },
  },
}
