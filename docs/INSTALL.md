# Install

Canonical skills live in `skills/`. Agent harnesses do not share one discovery path. The install script copies (does not rewrite) those skills into the paths each harness actually scans.

## Script

From this method pack:

```bash
./scripts/install.sh /path/to/consumer-repo
```

Windows:

```powershell
.\scripts\install.ps1 -Target C:\path\to\consumer-repo
```

Omit the target to install into the current directory (this repo dogfoods that way).

What it does:

- Copies `skills/{cranky,merge,cleanse}` →
  - `<target>/.agents/skills/`
  - `<target>/.claude/skills/`
  - `<target>/.grok/skills/`
- Copies `CLAUDE.md` pointer only if the target has no `CLAUDE.md`.
- Copies `templates/AGENTS/` → `<target>/AGENTS/` only if `<target>/AGENTS/` does not exist. **Never overwrites DNA.**
- Prints a reminder to write `AGENTS/overlays/overlay-<product>.md` and seed INVARIANTS.

It does not copy `docs/` (consumers can submodule or clone this pack). After install, skills still point at `docs/FORMAT.md` relative to the method pack; vendor copies include sibling `persona.md` / `taxonomy.md`. FORMAT rules are also summarized enough in persona.md to run if docs/ is absent.

Re-run install after pulling method-pack updates. Copies are the discovery trees; `skills/` in **this** repo remains the source of truth. In a consumer, the vendor dirs **are** the local source unless they keep a clone of this pack.

## Harness notes

| Harness | What it reads | After install |
|---|---|---|
| Grok | `AGENTS.md`, `.agents/skills/`, `.grok/skills/`, `.claude/skills/` | Works. Spawn a child; prepend `persona.md`; do not pass author intent. |
| Claude Code | `CLAUDE.md` / `AGENTS.md`, `.claude/skills/`, `.claude/commands/` | Works. Named subagent optional; child session + persona.md is enough. |
| Codex | `AGENTS.md`, skills dirs it documents | Works via `AGENTS.md` + `.agents/skills/` when supported; otherwise paste persona.md into a new thread. |
| Cursor | `AGENTS.md`, `.cursor/rules/` or `.cursor/skills/` | Install copies skills; also see `adapters/cursor/` if you want a rule pointer. |
| Copilot / others that implement [Agent Skills](https://agentskills.io) | `SKILL.md` packages | Same copies. |

Canonical files never name a single vendor's spawn API. If the harness cannot start a fresh child, stop and ask the human to paste `persona.md` into a new chat. Reviewing in the author context is not cranky.

## After install, before the first feature PR

1. Fill `AGENTS/DNA/` — especially INVARIANTS from bugs you already paid for.
2. Write an overlay ([docs/OVERLAYS.md](OVERLAYS.md)).
3. Point humans at `/cranky` and `/merge`.
4. Do not run cranky as a ritual on empty DNA and call the method installed.
