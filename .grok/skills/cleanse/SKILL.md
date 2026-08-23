---
name: cleanse
description: >-
  DNA hygiene: check AGENTS/DNA for contradictions and drift, and turn
  AGENT_MISTAKES patterns into proposed guardrails. Use when asked to
  /cleanse, cleanse DNA, audit invariants, or close the mistake loop.
---

# /cleanse

A project's DNA must stay self-consistent or it becomes fiction. Cleanse finds contradictions and, on a deep pass, patterns in AGENT_MISTAKES that deserve a guardrail.

Ask once: **shallow or deep?** Default to shallow if they do not say.

Human gates DNA edits. Propose, then wait, then implement if approved.

## Shallow

1. Read every file under `AGENTS/DNA/` (consumer repo). If that tree is missing, say so and stop — this pack's `templates/AGENTS/DNA/` is not the consumer's DNA.
2. Check internal consistency: contradictions, duplicated facts, references to files that do not exist.
3. Skim the implementation (tree + key files the DNA names). Flag anything obviously out of date.
4. Check DEFERRED for items already done.
5. Scan markdown under `AGENTS/` and `AGENTS.md` for broken wiki-style `[[links]]`. Fix broken links in place if the target is obvious; otherwise list them.

## Deep

Everything in shallow, plus:

1. Read the implementation the DNA claims to describe (not generated vendor UI). Verify DECISIONS still match libraries in use, ARCHITECTURE still matches the tree, PRODUCT still matches user-visible behavior.
2. If a schema/ORM exists, compare it to the live database **only when the consumer's DEVELOPMENT doc says how**. Do not invent connection strings.
3. Orphaned exports: files or symbols nothing imports, if cheap to detect.
4. **AGENT_MISTAKES patterns.** Recurring categories → propose a workflow, DNA, or code guard. Do not mint a rule for a one-off. Mark addressed patterns `[learned]` only after the human accepts the guard.
5. Suggest DNA or AGENTS.md edits that would have prevented a pattern. Do not apply them until approved.

## Do not

- Prune tests by a framework-specific ideology this pack does not own.
- Overwrite DNA because code drifted without asking which side is source of truth.
- Dump a second copy of [taxonomy.md](../cranky/taxonomy.md) into DNA.

## Output

List issues with a proposed fix each. Wait for the human. If they approve, branch, apply, open a PR, offer `/cranky` then `/merge`.
