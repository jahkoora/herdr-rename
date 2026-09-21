# Name the agent in this pane (or another): agentname my-agent | agentname w1:p7 my-agent | agentname --clear
agentname() {
  local target="${HERDR_PANE_ID:-}" name="$1"
  [ $# -eq 2 ] && target="$1" && name="$2"
  [ -z "$target" ] && { echo "not inside a herdr pane; give a pane id"; return 1; }
  local out; out=$(herdr agent rename "$target" "$name" 2>&1)
  if print -r -- "$out" | grep -q '"error"'; then print -r -- "$out" | grep -o '"message":"[^"]*"'; return 1; fi
  if [ "$name" = "--clear" ]; then herdr pane rename "$target" >/dev/null 2>&1; else herdr pane rename "$target" "$name" >/dev/null 2>&1; fi
  echo "renamed $target -> $name"
}
