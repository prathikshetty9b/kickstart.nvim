-- glow.nvim — terminal Markdown preview via charmbracelet/glow
-- https://github.com/ellisonleao/glow.nvim (archived; still works with glow on PATH)

---@module 'lazy'
---@type LazySpec
return {
  'ellisonleao/glow.nvim',
  ft = { 'markdown', 'mkd' },
  cmd = { 'Glow' },
  opts = {
    border = 'shadow',
    pager = false,
    width_ratio = 0.7,
    height_ratio = 0.7,
  },
  config = function(_, opts)
    require('glow').setup(opts)
  end,
  keys = {
    {
      '<leader>mp',
      '<cmd>Glow<cr>',
      desc = 'Markdown [p]review (glow)',
      ft = { 'markdown', 'mkd' },
    },
  },
}
