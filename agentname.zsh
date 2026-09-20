# Name the agent in this pane (or another): agentname my-agent | agentname w1:p7 my-agent | agentname --clear
agentname() {
  local target="${HERDR_PANE_ID:-}" name="$1"
  [ $# -eq 2 ] && target="$1" && name="$2"
  [ -z "$target" ] && { echo "not inside a herdr pane; give a pane id"; return 1; }
  herdr agent rename "$target" "$name" | grep -o '"error":{[^}]*}' || echo "renamed $target -> $name"
}
