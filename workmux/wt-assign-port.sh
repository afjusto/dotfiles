#!/usr/bin/env bash
# Assigns a unique PORT to a workmux worktree and records it in .workmux.env.
# Run as a workmux post_create hook (cwd = the new worktree).
#
# - Rails uses $PORT; Vite uses $PORT+99 (see bin/dev). We pick a base PORT in
#   steps of 100 so the Rails and Vite ranges of different worktrees never overlap.
# - Skips ports already in use, and ports already claimed by sibling worktrees'
#   .workmux.env files, so concurrent creation doesn't collide.
# The tmux window is renamed by the pane command (which runs inside the new
# window), not here — post_create runs in the invoking pane, not the worktree's.
set -euo pipefail

worktree_dir="$(pwd)"
branch="$(git -C "$worktree_dir" symbolic-ref --short HEAD 2>/dev/null || echo worktree)"

# Collect ports already claimed by sibling worktrees' .workmux.env files.
parent="$(dirname "$worktree_dir")"
claimed=""
for envf in "$parent"/*/.workmux.env; do
  [ -f "$envf" ] || continue
  p="$(grep -E '^PORT=' "$envf" 2>/dev/null | head -1 | cut -d= -f2)"
  [ -n "$p" ] && claimed="$claimed $p"
done

port_free() {
  local p="$1"
  case " $claimed " in *" $p "*) return 1 ;; esac          # claimed by a sibling
  lsof -nP -iTCP:"$p" -sTCP:LISTEN >/dev/null 2>&1 && return 1   # in use now
  local vp=$((p + 99))
  lsof -nP -iTCP:"$vp" -sTCP:LISTEN >/dev/null 2>&1 && return 1  # vite port in use
  return 0
}

# Start at 3000 and step by 1 (3000, 3001, 3002, ...). port_free() already
# rejects a port whose Rails OR Vite (port+99) side is taken, so sequential
# ports stay collision-free in practice (first theoretical clash is 99 worktrees in).
port=3000
while ! port_free "$port"; do
  port=$((port + 1))
  [ "$port" -gt 3098 ] && { echo "wt-assign-port: no free port found" >&2; exit 1; }
done
vite=$((port + 99))

printf 'PORT=%s\nVITE_PORT=%s\n' "$port" "$vite" > "$worktree_dir/.workmux.env"

# .workmux.env is covered by the global gitignore (~/.gitignore_global).

echo "wt-assign-port: $branch → Rails :$port, Vite :$vite"
