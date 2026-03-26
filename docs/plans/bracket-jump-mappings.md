# Bracket jump mappings (insert mode)

## Goal

Add insert-mode shortcuts so `Ctrl-l` moves past closing brackets and quotes (and generally one character right when useful), and `Ctrl-h` moves one character left without leaving insert mode.

## Context

`nvim-autopairs` is already loaded from `lua/kickstart/plugins/autopairs.lua` with default options. Typing the same closing character again skips over it; dedicated `Ctrl-l` / `Ctrl-h` keys match common editor muscle memory and work even when skipping is not triggered by typing the closer.

## Design

- Configure mappings next to `nvim-autopairs` in [`lua/kickstart/plugins/autopairs.lua`](../../lua/kickstart/plugins/autopairs.lua) via a `config` hook after `require('nvim-autopairs').setup(opts)`.
- **`Ctrl-l`**: Use an `expr` mapping that inspects the byte after the cursor; if it is `)`, `]`, `}`, `"`, `'`, or `` ` ``, emit `<Right>` to step past it; otherwise still emit `<Right>` as the normal “move right one column” fallback in insert mode.
- **`Ctrl-h`**: Map to `<Left>` (insert mode) for one step left.

## Tasks

- [x] Create this planning doc
- [x] Add `config` to the autopairs LazySpec and define `i` mode `<C-l>` / `<C-h>` keymaps
- [x] Confirm no clash with existing global insert maps; run diagnostics on edited Lua

## Edge Cases / Risks

- Some terminals send backspace for `Ctrl-h`, so the mapping may not fire in every environment.
- Cursor column from `nvim_win_get_cursor` is byte-based; the closers are ASCII-only, so substring logic is safe for those characters.
- At end of line, `<Right>` may not move; that matches normal arrow behavior.

## Testing

- In insert mode after auto-pairs insert `()`, `[]`, `{}`, `""`, `''`, and `` `` ``, press `Ctrl-l` and confirm the cursor moves past the closing delimiter.
- With normal text after the cursor, `Ctrl-l` still moves one character right when possible.
- `Ctrl-h` moves one character left without leaving insert mode.
- Run `:verbose imap <C-l>` and `:verbose imap <C-h>` and confirm these mappings are defined from the autopairs plugin config.

## Implementation notes

- Mappings live in [`lua/kickstart/plugins/autopairs.lua`](../../lua/kickstart/plugins/autopairs.lua) in the plugin `config` callback, after `require('nvim-autopairs').setup(opts)`.
- `<C-l>` is an `expr` mapping that reads the byte after the cursor and returns `<Right>` (same for closers and non-closers).
- `<C-h>` maps to `<Left>` in insert mode. Normal-mode `<C-h>` / `<C-l>` in `init.lua` are window navigation only; no insert-mode conflict found.
