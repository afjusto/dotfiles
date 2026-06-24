---
name: pr-commit-and-pr
description: "Use when the user wants to commit their current work and open a draft PR. Triggers: 'commit and open a PR', 'ship this', 'open a draft PR for this'. Takes a conventional-commit type (feat, fix, chore, task, etc.)."
argument-hint: "<type> (feat, fix, chore, task, etc.)"
---

Commit the current work and open a draft PR, then kick off PR babysitting.

1. Commit with a `<type>: ...` simple lowercase message (the type comes from the argument). Be straight to the point — no notes or caveats.

2. Open a **draft** PR.

3. Use the `pr-update-description` skill to write the PR description following the repo template (`.github/pull_request_template.md`).

4. After the PR is open, launch a background agent (via the Agent tool with `run_in_background: true`) that runs the `pr-babysit-checks` skill for the new PR. The background agent watches the PR's CI test checks, reproduces any failing tests locally, and prepares fixes in the working tree — it must not push those fixes, leaving them uncommitted for review. Report the PR URL immediately and let the babysitting continue in the background; do not block on CI.
