---
name: pr-babysit-checks
description: "Use when a PR has failing or pending CI test checks, or right after opening a PR — to watch the CI test checks, reproduce failing tests locally, and prepare fixes for review. Never pushes. Triggers: 'my PR tests are failing', 'CI is red', 'check the build on my PR'."
argument-hint: "[PR number or URL] (defaults to the PR for the current branch)"
---

This skill watches a PR's automated **test** checks and prepares fixes locally. It does **not** touch reviewer comments — `pr-address-comments` owns that. It **never** pushes; all fixes land as uncommitted working-tree changes for the user to review.

This skill is typically run as a **background agent** (e.g. launched by `/commit-and-pr`), so it may run for several minutes while the user keeps working. Because of that:
- Only modify files that are part of a fix for a confirmed failing test. Never run destructive git commands (`reset`, `checkout --`, `stash`, `clean`) — the user may have unrelated unstaged work in the tree.
- Operate on the PR's branch; if the working tree is on a different branch when checks finish, do not switch it — report that the branch changed and stop.
- The final report is the deliverable. Surface it clearly so the user sees it when they return to the session.

1. **Identify the PR.** Use the argument if given, otherwise resolve the PR for the current branch: `gh pr view --json number,headRefName,url`. Confirm the local branch matches the PR's head branch before doing anything — never fix against the wrong checkout.

2. **Wait for the test checks to finish.** Poll until the test checks reach a conclusion (don't react to in-progress runs):
   ```bash
   gh pr checks --watch --fail-fast=false
   ```
   The relevant checks are the test jobs only:
   - `rspec (chunk N)`, `rspec (search backends)`, `rspec` — backend RSpec
   - `jest (shard N)`, `jest` — frontend Jest
   - `vitest (shard N)`, `vitest` — frontend Vitest

   Ignore non-test checks (lint, type, build, deploy) — the user runs those locally before opening the PR, and reviewer-comment-driven fixes are out of scope.

3. **Collect the failing tests.** For each failing test check, read its logs to find the exact failing examples/specs:
   ```bash
   gh pr checks --json name,state,link
   gh run view <run-id> --log-failed
   ```
   Extract the specific failing file paths and example names — not just the job name.

4. **Reproduce each failure locally.** Run only the failing tests, using the runner that matches the check:
   - Backend (`rspec`): `bin/rspec --no-profile --format progress <spec_file>[:line]`
   - Frontend (`jest`): `pnpm --filter ampledash exec jest <test_file>`
   - Frontend (`vitest`): `pnpm test:vitest:run <test_file>`

   Confirm the failure reproduces locally before changing anything. If a failure does **not** reproduce locally (flaky, infra, or environment-specific), do not invent a fix — note it for the user instead.

5. **Fix each reproduced failure.** Understand why the test fails and fix the **root cause** (usually the production code; sometimes the test if it encodes wrong behaviour). Follow the project's conventions — never add production branches, guards, or fallbacks that exist only to satisfy the test (see CLAUDE.md). Re-run the same targeted test to confirm it passes.

6. **Leave fixes uncommitted.** Do **not** stage, commit, or push. Leave every change in the working tree.

7. **Report for review.** Summarize concisely:
   - Which checks failed and the specific tests involved
   - What the root cause was and how each was fixed
   - Any failure that did **not** reproduce locally (left untouched, needs the user's judgment)
   - The command to review: `git diff`

   End by reminding the user that nothing was committed or pushed — the changes are theirs to review, then commit and push.
