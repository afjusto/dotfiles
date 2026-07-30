---
name: pr-address-pending-review
description: "Fetch and address the authenticated GitHub user's unsubmitted PENDING pull-request review comments as a private work queue. Use when the user asks to inspect, list, triage, or implement their own draft or pending GitHub PR review comments without publishing them, including requests such as 'address my pending review', 'apply my private review comments', or 'show my draft review comments'."
---

# Address Pending PR Review

Use the user's pending GitHub review as a private, line-aware work queue. Keep the review pending and private throughout the workflow.

## Workflow

1. Resolve the pull request.
   - Use an explicit PR URL, repository, and number when provided.
   - Otherwise resolve the current branch with `gh pr view --json number,url,headRefName`.
   - Read the repository's agent instructions before changing code.
2. Verify context.
   - Get the authenticated account with `gh api user --jq .login`.
   - Before editing, confirm the worktree branch and repository correspond to the PR head. Stop rather than changing an unrelated checkout.
3. Fetch the pending review.
   - Resolve `scripts/fetch_pending_review.sh` relative to this `SKILL.md`, then run it as `fetch_pending_review.sh OWNER REPO PR_NUMBER`.
   - Treat its JSON output as private user input. Do not save it in the repository.
   - Do not rely on `gh pr view --comments`; it is not a complete source for pending review comments.
4. Select the operation from the user's wording.
   - For inspect, list, or summarize requests, remain read-only and report the comments.
   - For address, apply, or fix requests, classify every comment as actionable, a question or decision, already addressed, or non-actionable.
   - Group related comments by behavior or file. Ask only about choices that materially affect behavior; otherwise use repository context and state the assumption.
5. Locate each comment in the current code.
   - Use `path`, `line`, `start_line`, `side`, and `diff_hunk` together.
   - Expect line fields to be null or stale after pushes. Match the diff hunk and surrounding symbols instead of trusting line numbers alone.
   - Compare the review's `commit_id` with the current PR head. If they differ, verify whether the requested change is still relevant before editing.
6. Implement selected changes.
   - Keep every edit traceable to one or more pending comment IDs.
   - Follow repository conventions and production behavior. Do not add production-only exceptions to satisfy tests.
   - For feedback asking a question rather than clearly requesting a change, investigate and either make the well-supported improvement or report a concise recommendation.
7. Verify in repository-prescribed order.
   - Run focused tests first.
   - Run formatting, linting, and type checking only as required by the repository instructions and only after tests pass.
8. Report the result.
   - List addressed comments, comments requiring a decision, comments needing no change, and verification performed.
   - Identify comments by ID and file so the user can reconcile the report with the pending review.
   - State explicitly that the GitHub review remains pending and unchanged.

## GitHub Write Safety

- Never submit, approve, request changes, reply to, resolve, edit, delete, or abandon the pending review unless the user explicitly requests that specific GitHub write.
- Never commit or push code unless the user requests it or the active repository workflow explicitly includes it.
- Do not copy pending comment text into public PR comments, commit messages, or other published artifacts.
- Do not delete addressed pending comments automatically; preserve them for the user's verification.

## Fallback

If the script cannot fetch a review:

1. Confirm `gh` authentication and the authenticated username.
2. Confirm the PR coordinates and repository access.
3. Query `GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews`, select the review whose state is `PENDING` and whose author is the authenticated user, then query `GET /repos/{owner}/{repo}/pulls/{pull_number}/reviews/{review_id}/comments`.
4. Explain whether no review exists, the saved review belongs to another GitHub identity, or authentication failed.

Only comments saved with **Start a review** or **Add review comment** are retrievable. Text left in an unsaved browser editor is unavailable through the API.
