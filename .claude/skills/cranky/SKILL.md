---
name: cranky
description: >-
  Cold merge-gated code review with CRIT/MAJ/MIN/NIT and a ## VERDICT line.
  Use when asked to cranky, /cranky, cranky review, review before merge,
  or when /merge needs a verdict on the latest commit.
---

# /cranky

Run a **cold** cranky review on a diff. You are the orchestrator. The reviewer is a fresh child session. You do not author findings yourself.

Format: [docs/FORMAT.md](../../docs/FORMAT.md) (one home). Persona: [persona.md](persona.md). Taxonomy: [taxonomy.md](taxonomy.md).

## Resolve paths

This skill may be loaded from `skills/cranky/` (canonical) or from a vendor copy (`.agents/skills/cranky/`, `.claude/skills/cranky/`, `.grok/skills/cranky/`). Prefer sibling `persona.md` and `taxonomy.md`. Prefer the consumer repo's `docs/FORMAT.md` if present after install; otherwise use the method pack's `docs/FORMAT.md`.

## Arguments

Parse in order. First match wins.

| Input | Mode |
|---|---|
| empty | `local` (staged + unstaged + untracked) |
| `--local` | `local` |
| `--branch <name>` | `branch` vs default base (`main`, else `master`) |
| `--pr <n-or-url>` | `pr` |
| GitHub PR URL or `#?\d+` | `pr` |
| a git ref that exists | `branch` |

Reject unknown flags. `--pr` and `--branch` require a value.

## Steps

1. **Confirm git.** If cwd is not a work tree, stop.

2. **Collect the diff and pin the SHA.**
   - `local`: working tree vs `HEAD` (include untracked; skip if clean). SHA = `git rev-parse HEAD` plus note "plus working tree."
   - `branch`: `git merge-base` with origin/main (or origin/master), then diff merge-base..branch. SHA = branch tip.
   - `pr`: `gh pr view` for `headRefOid` + `gh pr diff`. SHA = `headRefOid`.
   Empty diff → print "No changes to review." Stop. Do not spawn a reviewer.
   Size: if the diff is huge (multi-MB), ask before continuing.

3. **Load context for the reviewer (paths, not paraphrases).**
   - Changed file list.
   - `AGENTS/overlays/*.md` if any.
   - `AGENTS/DNA/INVARIANTS.md` if present.
   Do **not** pass the PR body, ticket text, or "this change is supposed to."

4. **Counter-agents (optional).** If the file list clearly splits into unrelated subsystems (example: deploy config vs application code), you may spawn one scoped child per subsystem. Each child gets only its slice of the diff. They do not receive author intent. Then still run step 5.

5. **Holistic cranky (mandatory).** Launch a **fresh child session** with a clean context.
   - If the harness has named subagents / child sessions, use that. Prepend `persona.md`. Tell it to walk `taxonomy.md`. Point it at the diff path, file list, overlay paths, FORMAT.md, and the SHA.
   - If the harness cannot spawn children, stop and tell the human to paste `persona.md` into a new chat with the diff path. Do not review in the same context that wrote the code.
   - Prefix any spawn label with `[reviewer]` if the harness uses that for UI.
   - The child is read-only. It writes a review file if you give it a path; otherwise it returns the markdown in its final message.

6. **Parse.** Require `## VERDICT` and exactly one of `APPROVE` | `APPROVE WITH MINORS` | `REQUEST CHANGES`, plus `## SHA`. If malformed: re-run the child once with a format reminder. Second failure → treat as `REQUEST CHANGES` (fail closed).

7. **Report** the verdict, SHA, counts by severity, and the findings. Keep the review text.

8. **Learn (consumer repo only, and only if ledgers exist).** For each CRIT/MAJ that was real in this round, append a **category** line to `AGENTS/AGENT_MISTAKES.md` (date + short category, not a novel). If a runtime rule was taught, **propose** an INVARIANTS entry; do not edit DNA without the human.

You never patch product code. `/merge` (or the human) fixes and re-invokes `/cranky` on the new SHA.

## Forbidden

- Reviewing in the author session "to save a spawn."
- Feeding the child the PR description or implementer summary.
- Approving because CI is green.
- Skipping because the diff is small, docs-only, or a version bump.
- Inventing findings to fill space.
- Using bug/suggestion/nit labels. Use CRIT/MAJ/MIN/NIT.
