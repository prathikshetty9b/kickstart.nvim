# Terminal Markdown preview in Neovim

## Goal

Preview Markdown inside Neovim using a terminal-style renderer (no browser): open the current file’s rendered output via the **glow** CLI, integrated with **glow.nvim**.

## Context

- Kickstart.nvim + lazy.nvim; plugins live under `lua/kickstart/plugins/` and are required from `init.lua`.
- Treesitter already includes `markdown` / `markdown_inline` parsers.
- **Note**: [ellisonleao/glow.nvim](https://github.com/ellisonleao/glow.nvim) is archived; if it breaks on future Neovim versions, consider alternatives (e.g. `render-markdown.nvim` for in-buffer rendering, or a raw `:terminal glow %` workflow).

## Design

- **CLI**: [glow](https://github.com/charmbracelet/glow) — install separately (`brew install glow` on macOS).
- **Plugin**: `ellisonleao/glow.nvim` — lazy-load for `markdown` (and `mkd`), `:Glow` / `:Glow!`, optional `<leader>mp` in markdown buffers.

## Tasks

- [x] Create planning doc
- [x] Add `lua/kickstart/plugins/glow.lua` (LazySpec, `require('glow').setup`)
- [x] Register `require 'kickstart.plugins.glow'` in `init.lua`
- [x] Install `glow` CLI and verify `:Glow` on a `.md` file

## Edge Cases / Risks

- **Missing binary**: If `glow` is not on `PATH`, preview fails; install with `brew install glow` (or see charmbracelet/glow docs).
- **Unsaved buffer**: Preview may reflect last saved disk contents; save the buffer for an accurate preview.
- **Archived plugin**: No upstream fixes; monitor Neovim upgrades.
- **Lazy command registration**: Register only `Glow` in Lazy's `cmd` spec. `:Glow!` is valid as the `bang` form of `:Glow`, but `Glow!` is not a valid user-command name for `nvim_create_user_command`.

## Testing

- Install glow: `brew install glow` (macOS).
- Restart Neovim, open `docs/plans/markdown-terminal-preview.md`, run `:Glow`; confirm floating preview; close with `q` or `:Glow!`.
- Optional: in a markdown buffer, use `<leader>mp` to open preview.
- Run `:Lazy` and confirm `glow.nvim` loads without errors.
