#!/usr/bin/env bash
# Copy Cranky Review 2.0 skills into a consumer repo.
# Usage: ./scripts/install.sh [target-repo]
# Default target: current working directory.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PACK_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET="${1:-"$PWD"}"

if [ ! -d "$TARGET" ]; then
  echo "install.sh: target is not a directory: $TARGET" >&2
  exit 1
fi
if [ ! -d "$PACK_ROOT/skills/cranky" ]; then
  echo "install.sh: cannot find skills/cranky under $PACK_ROOT" >&2
  exit 1
fi

copy_skill() {
  local name="$1"
  local dest="$2"
  mkdir -p "$dest"
  rm -rf "$dest/$name"
  cp -R "$PACK_ROOT/skills/$name" "$dest/$name"
}

for dest in \
  "$TARGET/.agents/skills" \
  "$TARGET/.claude/skills" \
  "$TARGET/.grok/skills"
do
  mkdir -p "$dest"
  copy_skill cranky "$dest"
  copy_skill merge "$dest"
  copy_skill cleanse "$dest"
done

mkdir -p "$TARGET/.claude/commands" "$TARGET/.claude/agents"
cp "$PACK_ROOT/adapters/claude/commands/"*.md "$TARGET/.claude/commands/"
cp "$PACK_ROOT/adapters/claude/agents/cranky-reviewer.md" "$TARGET/.claude/agents/"

if [ ! -f "$TARGET/CLAUDE.md" ]; then
  cp "$PACK_ROOT/CLAUDE.md" "$TARGET/CLAUDE.md"
  echo "installed CLAUDE.md pointer (target had none)"
fi

if [ ! -d "$TARGET/AGENTS" ]; then
  mkdir -p "$TARGET/AGENTS"
  cp -R "$PACK_ROOT/templates/AGENTS/." "$TARGET/AGENTS/"
  echo "installed AGENTS/ templates (target had none — seed INVARIANTS before relying on cranky)"
else
  echo "left existing AGENTS/ untouched"
fi

mkdir -p "$TARGET/.cursor/rules"
if [ ! -f "$TARGET/.cursor/rules/cranky.mdc" ]; then
  cp "$PACK_ROOT/adapters/cursor/cranky.mdc" "$TARGET/.cursor/rules/cranky.mdc"
fi

echo "Cranky Review 2.0 installed into $TARGET"
echo "  skills → .agents/skills .claude/skills .grok/skills"
echo "Next: write AGENTS/overlays/overlay-<product>.md and seed AGENTS/DNA/INVARIANTS.md"
echo "Inspired by https://github.com/ulfaslak/saas_tmplt — see NOTICE.md"
