---
name: pr-commit-and-pr
description: "Use when the user wants to commit their current work and open a draft PR. Triggers: 'commit and open a PR', 'ship this', 'open a draft PR for this'. Takes a conventional-commit type (feat, fix, chore, task, etc.)."
argument-hint: "<type> (feat, fix, chore, task, etc.)"
---

Commit the current work and open a draft PR.

1. Commit with a `<type>: ...` simple lowercase message (the type comes from the argument). Be straight to the point — no notes or caveats.

2. Open a **draft** PR.

3. Use the `pr-update-description` skill to write the PR description following the repo template (`.github/pull_request_template.md`).

4. Report the PR URL.
