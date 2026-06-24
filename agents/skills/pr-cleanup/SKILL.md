---
name: pr-cleanup
description: "Use after a PR has been merged on GitHub to clean up its worktree, tmux window, and local branch via workmux. Triggers: 'clean up the worktree', 'the PR merged, remove this', 'tear down this branch'. Does NOT merge — the PR is already merged on the remote."
argument-hint: "[worktree name(s)] (defaults to the current worktree)"
---

Clean up a worktree after its PR has already been merged on GitHub. This does **not** merge anything — `workmux merge` is for direct merges without a PR; this skill is for the PR workflow, where the merge already happened on the remote.

1. **Confirm the PR is merged.** If unsure, check with `gh pr view --json state,mergedAt` for the current branch's PR. If it is not merged yet, stop and tell the user — do not remove an un-merged worktree without explicit confirmation.

2. **Choose the removal mode:**
   - **By argument:** if the user named one or more worktrees, run `workmux remove <name>...`.
   - **Current worktree:** if no argument and the user is inside the worktree's tmux pane, run `workmux remove` with no name — it defaults to the current directory's worktree and tears down its worktree + tmux window + local branch.
   - **Bulk, post-merge:** to sweep every worktree whose remote branch was deleted after merging (the common case), run `workmux rm --gone`. This runs `git fetch --prune` first and removes all worktrees whose upstream is gone. Prefer this when cleaning up several merged PRs at once.

3. **Respect safety.** `workmux remove` skips worktrees with uncommitted changes or unmerged commits unless `--force` is passed. Do not pass `--force` unless the user explicitly asks — surface what was skipped instead.

4. **Report** which worktrees, tmux windows, and branches were removed, and anything that was skipped (and why).

Note: running `workmux remove` from inside the worktree's own tmux window will also close that window — that is expected.
