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
        curl -fsSL "$REPO_RAW_BASE/$PLUGIN_REL_DIR/$file" -o "$DEST_DIR/$file" </dev/null
    fi
done

[[ -f "$DEST_DIR/__init__.py" ]] || error "Installation failed: __init__.py not found"
[[ -f "$DEST_DIR/plugin.yaml" ]] || error "Installation failed: plugin.yaml not found"

ENV_FILE="$HERMES_HOME/.env"
if [[ ! -f "$ENV_FILE" ]]; then
    printf 'AURIKO_API_KEY=\n' >> "$ENV_FILE"
elif ! grep -q '^AURIKO_API_KEY=' "$ENV_FILE"; then
    printf '\nAURIKO_API_KEY=\n' >> "$ENV_FILE"
fi

HERMES_BIN=""
if command -v hermes &>/dev/null; then
    HERMES_BIN="hermes"
elif [[ -x "$HERMES_HOME/bin/hermes" ]]; then
    HERMES_BIN="$HERMES_HOME/bin/hermes"
fi

if [[ -n "$HERMES_BIN" ]] \
&& "$HERMES_BIN" config set providers.auriko.base_url "https://api.auriko.ai/v1" 2>/dev/null \
&& "$HERMES_BIN" config set providers.auriko.key_env  "AURIKO_API_KEY"            2>/dev/null; then
    :
else
    info "Open a new terminal, then run:"
    info "  hermes config set providers.auriko.base_url https://api.auriko.ai/v1"
    info "  hermes config set providers.auriko.key_env AURIKO_API_KEY"
fi

info "Auriko plugin installed to $DEST_DIR"
info ""
info "Next steps:"
info "  1. Add your key to ~/.hermes/.env:  AURIKO_API_KEY=ak_live_..."
info "  2. hermes model  (select Auriko, pick a default model)"
info "  3. hermes chat"
info ""
info "To uninstall: rm -rf $DEST_DIR && hermes config unset providers.auriko"
