# Go Support for Neovim

## Goal

Enable full Go language support in Neovim: autocomplete, formatting, code suggestions, diagnostics, go-to-definition, and syntax highlighting.

## Context

The kickstart.nvim config already ships with the plugin infrastructure (Mason, nvim-lspconfig, conform.nvim, Treesitter, blink.cmp). Go support requires wiring `gopls` and Go-specific tools into each layer.

## Design

- **LSP**: `gopls` (official Go language server) added to the `servers` table with staticcheck and gofumpt enabled.
- **Formatting**: `goimports` + `gofumpt` via conform.nvim for format-on-save.
- **Syntax highlighting**: Treesitter parsers for `go`, `gomod`, `gosum`.
- **Linting (optional)**: `golangci-lint` via nvim-lint.
- **Tool management**: Mason auto-installs all tools.

## Tasks

- [x] Create planning doc
- [x] Add `gopls` to LSP servers table in `init.lua`
- [x] Add `goimports`, `gofumpt` to Mason `ensure_installed`
- [x] Add Go formatters to conform.nvim `formatters_by_ft`
- [x] Add `go`, `gomod`, `gosum` to Treesitter parsers
- [x] Enable lint plugin and add `golangci-lint` for Go

## Edge Cases / Risks

- Go must be installed on the system (`go version` must work) before Mason can install `gopls`.
- `golangci-lint` requires a `go.mod` project; it won't run on standalone `.go` files.
- `gofumpt` is stricter than `gofmt`; team projects may prefer standard `gofmt` only.

## Testing

- Open a `.go` file and verify syntax highlighting works (Treesitter).
- Type code and confirm autocomplete suggestions appear (gopls + blink.cmp).
- Save a file and confirm it is auto-formatted (conform.nvim).
- Use `grd` to go-to-definition, `grr` for references.
- Run `:Mason` and verify `gopls`, `goimports`, `gofumpt` are installed.
- Run `:checkhealth` and verify no errors for LSP/Treesitter.
