# /kaltura-brand-voice

A Kaltura-specific skill for brand-voice setup, refresh, and quick reference.

## Trigger

User types `/kaltura-brand-voice` optionally followed by a subcommand:
- `/kaltura-brand-voice` or `/kaltura-brand-voice help` — show the brand cheat-sheet and available commands
- `/kaltura-brand-voice update` — re-download brand-guidelines.md from the private repo
- `/kaltura-brand-voice check [file]` — run brand-voice check on a file or the current project
- `/kaltura-brand-voice setup` — (re)install everything from scratch

## Instructions

### Default (no args or `help`)

Print the Kaltura brand cheat-sheet as a clean formatted block — do NOT call any tools, just output the text:

```
Kaltura Brand Voice — Quick Reference

Voice:    Energy · Clarity · Warmth
Person:   Second ("you", never "users")
Voice:    Active · Short sentences (max 25 words)
Tone:     Confident, not breathless · Empathetic, not corporate

✓ Always use:
  Kaltura · Content Hubs · LMS Extensions · Rich Media CMS
  Kaltura Room · Agentic DX Platform · Agentic Avatars · Genies
  Content Lab · Live Studio · Interactive Video Paths
  Kaltura Events & Webinars · Kaltura Player

✗ Avoid:
  leverage · utilize · synergy · seamless · cutting-edge · robust
  innovative · game-changing · simply · easy · users · chatbots
  KMS · KAF · KMC · KME · EP · Newrow · Mediaspace

⛔ Forbidden (never use):
  "AI Content Lab" · "Video Portal" · "Events Platform"
  "Management Console" · "KAF" · "KME" · "Newrow" · "NR2"

Colors:   #282828 (primary) · #006efa (blue) · #ff9dff (pink)
          #ff3d23 (red) · #ffd357 (yellow) · #5bc686 (green)
Fonts:    Centra No.1 (headings) · Source Sans Pro (body)

Commands:
  /kaltura-brand-voice update   — refresh guidelines from GitHub
  /kaltura-brand-voice check    — check files in this project
  /kaltura-brand-voice setup    — reinstall everything
```

### `update`

Re-download the brand guidelines from the private GitHub repo. Run this bash command:

```bash
gh api "repos/kaltura/brand-voice-config/contents/brand-guidelines.md" --jq '.content' \
  | base64 --decode > "$HOME/.claude/brand-guidelines.md"
```

Then confirm: "Kaltura brand guidelines updated at ~/.claude/brand-guidelines.md"

If the command fails (e.g. auth issue), tell the user: "Make sure you're authenticated: run `gh auth login` and try again."

### `check [file]`

If a file path was given, run: `brand-voice check <file>`
Otherwise run: `brand-voice check` in the current working directory.
Show the output and explain any violations in the context of Kaltura brand rules.

### `setup`

Run the full installer:

```bash
curl -fsSL https://raw.githubusercontent.com/kaltura/brand-voice-config/main/install.sh | bash
```

If `curl` or `gh` are missing, tell the user what to install first.
