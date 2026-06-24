---
name: pr-update-description
description: "Use when a PR's description needs writing or refreshing — after opening a PR, after pushing new commits that change scope, or when the user says the description is stale/empty. Fills the repo template from the branch's diff and commits. Triggers: 'update my PR description', 'write the PR body', 'the description is out of date'."
argument-hint: "[PR number or URL] (defaults to the PR for the current branch)"
---

Write or update a PR description that follows the repo's PR template, derived from what actually changed on the branch. Works on a fresh PR or one already in progress.

1. **Identify the PR.** Use the argument if given, otherwise resolve the PR for the current branch: `gh pr view --json number,url,body,baseRefName,headRefName`. If no PR exists yet, stop and report that — this skill updates an existing PR's description.

2. **Load the repo template** from `.github/pull_request_template.md`. Use its exact headings and structure. Never replace the template with a custom body. Preserve verbatim:
   - The trailing **"Relevant docs for reviewer"** block (and its links)
   - The HTML comment hints (e.g. the screenshots and design-review reminders)

3. **Understand the change.** Read the diff and commits against the base branch:
   ```bash
   git diff <base>...HEAD
   git log <base>...HEAD --format="%s%n%b"
   ```
   Use the conversation context too, if any, to capture intent the diff alone doesn't show.

4. **Fill the template, preserving existing content.** Take the PR's current body as the starting point. For each section:
   - **Context** — why this change is needed. Keep any existing prose; only fill it if empty.
   - **Solution** — what the change does and how. Keep existing prose; append genuinely new points the diff reveals that aren't already covered.
   - **Notes / Caveats** — trade-offs, follow-ups, risks. Keep existing entries; add new ones only if real.

   Do **not** overwrite or reword content the user already wrote. Only fill empty sections and append new, non-duplicate points. If a section has nothing to add, leave it as-is.

5. **Match the user's style.** Terse and direct — no filler, no caveats that aren't real, no AI-preamble. Lead with the "why" before the "how".

6. **Write it back directly:**
   ```bash
   gh pr edit <number> --body "<full template-shaped body>"
   ```

7. **Report** the PR URL and a one-line summary of which sections were changed (filled vs. augmented vs. left untouched).
