# Kaltura brand-voice config

Kaltura-specific configuration for [brand-voice](https://github.com/zoharbabin/brand-voice) — enforces Kaltura brand writing guidelines in Claude Code automatically.

## What this does

- Installs `brand-voice` globally
- Writes Kaltura's `brand-guidelines.md` to `~/.claude/` (applies to all your projects)
- Registers the PostToolUse hook so every `.md`/`.mdx` file Claude writes is checked
- Adds the `/kaltura-brand-voice` Claude Code skill for on-demand reference and updates

After install, every time Claude writes or edits a Markdown file it checks for Kaltura brand violations — wrong product names, forbidden terms, passive voice, long sentences — and self-corrects before saving.

## Install

You need:
- **Node.js 18+**

Then run:

```sh
curl -fsSL https://raw.githubusercontent.com/kaltura/brand-voice-config/main/install.sh | bash
```

That's it. Open any Claude Code session and the hook is active.

## The `/kaltura-brand-voice` skill

After install, you have a permanent slash command in every Claude Code session:

| Command | What it does |
|---|---|
| `/kaltura-brand-voice` | Show the Kaltura brand cheat-sheet |
| `/kaltura-brand-voice update` | Pull the latest guidelines from this repo |
| `/kaltura-brand-voice check [file]` | Run a brand check on a file or project |
| `/kaltura-brand-voice setup` | Re-run the full installer |

## Updating guidelines

When brand guidelines change, update `brand-guidelines.md` in this repo and commit. Kalturians pick up the change by running:

```sh
/kaltura-brand-voice update
```

Or re-running the install script.

## What gets enforced

| Rule | Example violation |
|---|---|
| Forbidden product names | "KMS", "KAF", "KMC", "KME", "Newrow", "NR2" |
| Forbidden phrases | "AI Content Lab", "Video Portal", "Management Console" |
| Avoid terms | leverage, utilize, synergy, seamless, robust, innovative, simply |
| Sentence length | > 25 words |
| Passive voice | "is configured", "was sent" |

## Suppressing a violation

Add `<!-- brand-voice-disable-line -->` to suppress a specific line, or add paths to `.brand-voice-ignore` for files that shouldn't be checked (changelogs, generated docs, etc.).

## Repo contents

```
brand-guidelines.md        Kaltura brand configuration (parsed by brand-voice)
install.sh                 One-command installer
skills/
  kaltura-brand-voice.md   Claude Code skill — /kaltura-brand-voice command
```
