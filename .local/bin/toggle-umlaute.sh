#!/bin/bash

CONFIG_DIR="$HOME/.config/espanso"
MATCH_FILE="$CONFIG_DIR/match/umlauts.yml"
STATE_FILE="$CONFIG_DIR/umlauts_enabled"

enable_mappings() {
  cat > "$MATCH_FILE" <<EOF
matches:
  - trigger: ":o:"
    replace: "ö"
  - trigger: ":a:"
    replace: "ä"
  - trigger: ":u:"
    replace: "ü"
  - trigger: ":O:"
    replace: "Ö"
  - trigger: ":A:"
    replace: "Ä"
  - trigger: ":U:"
    replace: "Ü"
  - trigger: ":sz:"
    replace: "ß"
EOF

  espanso restart
  echo "on" > "$STATE_FILE"
  echo "Umlaut mappings ENABLED"
}

disable_mappings() {
  rm -f "$MATCH_FILE"
  espanso restart
  echo "off" > "$STATE_FILE"
  echo "Umlaut mappings DISABLED"
}

# Main logic
if [ -f "$STATE_FILE" ] && grep -q "on" "$STATE_FILE"; then
  disable_mappings
else
  enable_mappings
fi
