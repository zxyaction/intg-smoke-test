#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_BASE="https://raw.githubusercontent.com/zxyaction/intg-smoke-test/main"
PLUGIN_REL_DIR="hermes-agent/plugin"
HERMES_HOME="${HERMES_HOME:-$HOME/.hermes}"
DEST_DIR="$HERMES_HOME/plugins/model-providers/auriko"

info()  { printf '\033[0;34m%s\033[0m\n' "$1"; }
error() { printf '\033[0;31mError: %s\033[0m\n' "$1" >&2; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd 2>/dev/null || echo "")"

mkdir -p "$DEST_DIR"

for file in __init__.py plugin.yaml; do
    local_path="$SCRIPT_DIR/plugin/$file"
    if [[ -n "$SCRIPT_DIR" && -f "$local_path" ]]; then
        cp "$local_path" "$DEST_DIR/$file"
    else
        curl -fsSL "$REPO_RAW_BASE/$PLUGIN_REL_DIR/$file" -o "$DEST_DIR/$file"
    fi
done

[[ -f "$DEST_DIR/__init__.py" ]] || error "Installation failed: __init__.py not found"
[[ -f "$DEST_DIR/plugin.yaml" ]] || error "Installation failed: plugin.yaml not found"

info "Auriko plugin installed to $DEST_DIR"
info ""
info "Next steps:"
info "  1. export AURIKO_API_KEY=\"ak_live_...\""
info "  2. hermes model  (select Auriko, confirm API key, pick a model)"
info "  3. hermes chat"
info ""
info "To uninstall: rm -rf \"$DEST_DIR\""
