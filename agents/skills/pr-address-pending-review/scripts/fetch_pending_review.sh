#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: fetch_pending_review.sh OWNER REPO PR_NUMBER" >&2
  exit 2
fi

owner=$1
repo=$2
pr_number=$3

if ! [[ $pr_number =~ ^[0-9]+$ ]]; then
  echo "PR_NUMBER must be a positive integer" >&2
  exit 2
fi

for command_name in gh jq; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Required command not found: $command_name" >&2
    exit 127
  fi
done

authenticated_user=$(gh api user --jq '.login')
reviews_json=$(gh api --paginate --slurp \
  "repos/${owner}/${repo}/pulls/${pr_number}/reviews?per_page=100")
pending_reviews=$(jq --arg login "$authenticated_user" \
  '[.[][] | select(.state == "PENDING" and .user.login == $login)]' \
  <<<"$reviews_json")
pending_count=$(jq 'length' <<<"$pending_reviews")

if [[ $pending_count -eq 0 ]]; then
  echo "No pending review by ${authenticated_user} on ${owner}/${repo}#${pr_number}" >&2
  exit 1
fi

if [[ $pending_count -gt 1 ]]; then
  echo "Found multiple pending reviews by ${authenticated_user}; refusing to choose one" >&2
  exit 1
fi

review=$(jq '.[0]' <<<"$pending_reviews")
review_id=$(jq -r '.id' <<<"$review")
comments_json=$(gh api --paginate --slurp \
  "repos/${owner}/${repo}/pulls/${pr_number}/reviews/${review_id}/comments?per_page=100")
comments=$(jq '[.[][]]' <<<"$comments_json")

jq -n \
  --argjson review "$review" \
  --argjson comments "$comments" \
  '{
    review: ($review | {
      id,
      author: .user.login,
      state,
      body,
      commit_id,
      submitted_at
    }),
    comments: ($comments | map({
      id,
      path,
      body,
      line,
      side,
      start_line,
      start_side,
      commit_id,
      original_commit_id,
      diff_hunk,
      created_at
    }))
  }'
