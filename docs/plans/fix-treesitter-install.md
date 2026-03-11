# Fix nvim-treesitter install error

## Goal
Fix `attempt to call field 'install' (a nil value)` error at init.lua:894.

## Context
- Using `branch = 'main'` for nvim-treesitter, which underwent a full rewrite
- The `main` branch exposes `require('nvim-treesitter').install(parsers)` but the local clone may still be on `master` (which lacks this function)
- Error crashes Neovim startup

## Design
- Wrap the `install` call in a `pcall` so it degrades gracefully if the API isn't available yet
- After running `:Lazy sync`, the `main` branch will be checked out and the call will work

## Tasks
- [x] Add pcall protection around the `install` call in init.lua line 894

## Edge Cases / Risks
- First-time startup after changing branch: Lazy needs to sync before the API is available
- pcall silently swallows errors — we log a warning so it's visible

## Testing
- Open Neovim — should no longer crash
- Run `:Lazy sync` — should switch to main branch
- Reopen Neovim — treesitter parsers should install correctly
