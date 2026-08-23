---
name: merge
description: >-
  Merge a GitHub PR. Always runs /cranky on the latest commit first.
  Never merges without ## VERDICT APPROVE (or APPROVE WITH MINORS the human
  already accepted). Use when asked to merge, merge this, merge when CI greens,
  merge PR #N, or /merge.
---

# /merge

Cranky is a precondition for merge, not a courtesy. No PR is too small.

Read cranky format from [docs/FORMAT.md](../../docs/FORMAT.md). Run cranky via [skills/cranky/SKILL.md](../cranky/SKILL.md) — do not invent a parallel reviewer.

## Hard rules

1. Never `gh pr merge` without a cranky review on the **latest** head SHA. Force-push invalidates a prior verdict.
2. Verdict must be `APPROVE`, or `APPROVE WITH MINORS` if the human already accepted shipping MINs as deferrable. `REQUEST CHANGES` with any CRIT or MAJ blocks.
3. CI must be green on **that same SHA**.
4. Never skip because the PR is small, trivial, docs-only, or a version bump. Version constraints are a security boundary; docs can lie; CI tests behavior, cranky audits intent and threat model.
5. Only override: the human types `/merge --skip-cranky` or "merge without cranky" (or equivalent). Restate that they are overriding and confirm before merging.

## Workflow

1. Identify the PR (`$ARGUMENTS` number/URL, else `gh pr view --json number` for the current branch).
2. Read `headRefOid` and `headRefName`. If you are on the branch, confirm it matches `git rev-parse HEAD`.
3. `gh pr checks`. Any required check `pending` or `failure` → do not merge. If only pending, wait or watch, then continue.
4. Run `/cranky --pr <n>` unless cranky already ran on this exact SHA with a parseable VERDICT.
5. `REQUEST CHANGES` with CRIT or MAJ → stop. Report findings. After fixes are pushed, cranky the new SHA. Loop until APPROVE.
6. `APPROVE` (or accepted `APPROVE WITH MINORS`): re-check CI still green on the same SHA, then merge.

Default merge: `gh pr merge <n> --squash --delete-branch`. A consumer overlay may name a different strategy (`--merge` / `--rebase`); if none, squash.

7. Verify `state` is merged. Pull `main` locally if useful.

## Do not

- Spawn a generic "be cranky" agent. Invoke the cranky skill.
- Merge on a stale APPROVE.
- Treat skip-rationalizations as reasons (docs-only, version bump, similar PR already approved, CI green, three lines, hurry).
