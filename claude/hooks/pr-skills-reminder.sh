#!/usr/bin/env bash
# Fires after a `gh pr create`. Reminds about the PR skills so they don't get
# forgotten when a PR is opened outside of /commit-and-pr.
input=$(cat)
command=$(jq -r '.tool_input.command // ""' <<<"$input")

if [[ "$command" =~ gh[[:space:]]+pr[[:space:]]+create ]]; then
  reminder="A PR was just opened. Consider suggesting these skills to the user (do not run them automatically without checking first): pr-update-description (write/refresh the PR body from the repo template), pr-babysit-checks (watch CI test checks and prepare fixes once CI runs), pr-address-comments (act on reviewer/bot comments once they arrive)."
  jq -nc --arg r "$reminder" '{
    "hookSpecificOutput": {
      "hookEventName": "PostToolUse",
      "additionalContext": $r
    }
  }'
fi
exit 0
