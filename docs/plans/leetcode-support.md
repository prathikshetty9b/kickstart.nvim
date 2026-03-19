# LeetCode Support

## Goal

Integrate [kawre/leetcode.nvim](https://github.com/kawre/leetcode.nvim) to solve LeetCode problems directly inside Neovim.

## Context

- All required dependencies (`plenary.nvim`, `nui.nvim`) are already present via Telescope and Neo-tree.
- Telescope is used as the picker provider.
- Default language set to `cpp` to match existing C++ workflow.

## Design

- Plugin spec lives at `lua/kickstart/plugins/leetcode.lua`.
- Lazy-loaded via `cmd = "Leet"` so there is zero startup cost.
- `build = ":TSUpdate html"` ensures HTML treesitter parser is available for description formatting.
- `plugins.non_standalone = true` allows `:Leet` to work even when buffers are open.

## Tasks

- [x] Create `lua/kickstart/plugins/leetcode.lua`
- [x] Add `require 'kickstart.plugins.leetcode'` in `init.lua`
- [x] Create this plan document

## Usage

- `:Leet` — open the LeetCode dashboard
- `:Leet cookie update` — set your LeetCode session cookie (first-time setup; copy from browser **request** headers)
- `:Leet list` — browse all problems via Telescope
- `:Leet daily` — open today's daily problem
- `:Leet random` — open a random problem
- `:Leet run` — run the current solution against test cases
- `:Leet submit` — submit the current solution
- `:Leet exit` — close the LeetCode session

## Edge Cases / Risks

- Cookie must come from **request** headers, not `set-cookie` response headers.
- Brave browser users may need a workaround (see plugin FAQ).
- Requires Neovim >= 0.9.0.
