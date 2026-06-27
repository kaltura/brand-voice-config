#!/usr/bin/env bash
set -euo pipefail

REPO="kaltura/brand-voice-config"
RAW="https://raw.githubusercontent.com/${REPO}/main"
SKILL_NAME="kaltura-brand-voice"
BRAND_GUIDELINES_DEST="$HOME/.claude/brand-guidelines.md"
SKILL_DEST="$HOME/.claude/skills/${SKILL_NAME}.md"

echo "==> Kaltura brand-voice installer"
echo

# 1. Check dependencies
if ! command -v node &>/dev/null; then
  echo "ERROR: Node.js is required. Install from https://nodejs.org (v18+)."
  exit 1
fi
NODE_VERSION=$(node -e "process.stdout.write(process.versions.node)")
NODE_MAJOR="${NODE_VERSION%%.*}"
if [ "$NODE_MAJOR" -lt 18 ]; then
  echo "ERROR: Node.js 18+ is required (found $NODE_VERSION)."
  exit 1
fi

# 2. Install brand-voice
echo "==> Installing brand-voice..."
npm install -g brand-voice
echo "    brand-voice installed."
echo

# 3. Download Kaltura brand guidelines → global scope
echo "==> Downloading Kaltura brand guidelines..."
mkdir -p "$(dirname "$BRAND_GUIDELINES_DEST")"
curl -fsSL "${RAW}/brand-guidelines.md" -o "$BRAND_GUIDELINES_DEST"
echo "    Written to $BRAND_GUIDELINES_DEST"
echo

# 4. Install the Kaltura Claude skill
echo "==> Installing /kaltura-brand-voice skill..."
mkdir -p "$(dirname "$SKILL_DEST")"
curl -fsSL "${RAW}/skills/kaltura-brand-voice.md" -o "$SKILL_DEST"
echo "    Written to $SKILL_DEST"
echo

# 5. Register hook + MCP (brand-voice setup handles this idempotently)
echo "==> Registering PostToolUse hook and MCP server..."
brand-voice setup
echo

echo "==> Done! Kaltura brand-voice is active."
echo
echo "    In any Claude Code session:"
echo "      /kaltura-brand-voice       — show brand cheat-sheet & commands"
echo "      /kaltura-brand-voice update — refresh guidelines from GitHub"
echo
echo "    Every .md/.mdx file Claude writes is now checked automatically."
