#!/usr/bin/env bash
input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd // .workspace.current_dir // ""')
model=$(echo "$input" | jq -r '.model.display_name // ""')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

dir=$(basename "$cwd")
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

# --- First section: dir, branch, model ---
first=""
append_first() {
  if [ -n "$first" ]; then
    first="${first} $1"
  else
    first="$1"
  fi
}
[ -n "$dir" ]    && append_first "$(printf "\033[34m%s\033[0m" "$dir")"
[ -n "$branch" ] && append_first "$(printf "\033[35m%s\033[0m" "$branch")"
[ -n "$model" ]  && append_first "$(printf "\033[33m%s\033[0m" "$model")"

# --- Last section: context bar ---
last=""
if [ -n "$used" ]; then
  pct=$(printf '%.0f' "$used")
  segments=10
  filled=$(( (pct * segments + 50) / 100 ))
  [ "$filled" -gt "$segments" ] && filled=$segments
  [ "$filled" -lt 0 ] && filled=0
  empty=$(( segments - filled ))

  if [ "$pct" -ge 80 ]; then
    color="31"
  elif [ "$pct" -ge 50 ]; then
    color="33"
  else
    color="36"
  fi

  bar=""
  i=0
  while [ "$i" -lt "$filled" ]; do bar="${bar}█"; i=$((i + 1)); done
  i=0
  while [ "$i" -lt "$empty" ]; do bar="${bar}░"; i=$((i + 1)); done

  last=$(printf "\033[%sm%s %s%%\033[0m" "$color" "$bar" "$pct")
fi

# --- Join with a small gap ---
gap="    "
if [ -n "$first" ] && [ -n "$last" ]; then
  printf "%s%s%s\n" "$first" "$gap" "$last"
else
  printf "%s%s\n" "$first" "$last"
fi
