# Cranky Review 2.0 — contract

This repository is a **method pack**: cranky review, merge gating, DNA templates, and a cleanse loop. Drop it into a codebase you already have.

Contract shape inspired by [ulfaslak/saas_tmplt](https://github.com/ulfaslak/saas_tmplt); this file is original. Lineage: [docs/METHOD.md](docs/METHOD.md). Credit: [NOTICE.md](NOTICE.md).

Skills are for repeatable workflows (`/cranky`, `/merge`, `/cleanse`). Baseline behavior every session needs is **this file**.

## DNA

`AGENTS/DNA/` (in a **consumer** repo, after install) holds architectural guardrails. This pack ships empty templates under `templates/AGENTS/DNA/`.

Each file holds **one kind of statement**. A fact in two files drifts.

| File | Holds | Admission test |
|---|---|---|
| DECISIONS | A choice among alternatives we could have made differently. | Could someone violate it by choosing otherwise? Disagreeing means arguing with the human. |
| INVARIANTS | What must stay true at runtime, and the failure that taught it. | Could you write a test that fails when it stops being true? |
| ARCHITECTURE | Where code and data live. | Could you verify it with a file listing or by opening the file? |
| PRODUCT | What a user can observe. | Could a user see it? |
| DEVELOPMENT | How to work on the app: setup, test, ship. | Is it a thing you *do*, not a thing the app does? |

Rules:

1. Do not violate DNA.
2. Grow DNA when work adds structure.
3. Do not let it drift. If DNA and code disagree, find out which is wrong. If you are not certain, ask the human.
4. Do not take DNA edits lightly. Propose them; the human gates them.
5. Invariants are **earned from bugs**, not invented on a blank page.

Read the DNA files relevant to the task, not all of them by default. Server logic: DECISIONS + ARCHITECTURE + INVARIANTS. UI: + PRODUCT. Ship/ops: DEVELOPMENT.

## Where knowledge goes

An agent-private memory is invisible to the next agent, the next vendor, and the next machine. **Anything true about how the consumer repo behaves is written in that repo.**

| What you learned | Where it goes |
|---|---|
| A structural fact — a decision, a contract, a convention | `AGENTS/DNA/` (pick the file by the table above) |
| A guard a bug taught you | INVARIANTS |
| An environment trap or how to verify on prod | ENVIRONMENT_NOTES |
| A category of error worth not repeating | AGENT_MISTAKES |
| Tech debt with a trigger | DEFERRED |
| A check that can only run post-deploy | POST_MERGE_VERIFICATION |
| Something only a human can do (OAuth signup, legal copy) | HUMAN_TODO |
| Session-local preference | private memory (only this) |

DEFERRED is not a product backlog. Features go in the issue tracker. Every deferred item needs **What**, **Why deferred**, and a **Trigger**. "Someday" is not a trigger.

## Before writing code

- Work on a branch. Do not implement on `main` unless the human explicitly says to.
- Do not push to `main`. Open a PR.
- Issues describe product requirements, not file lists. An issue's technical claims are a **hypothesis**. Verify against the code before building.
- Read DNA that applies. Load `AGENTS/overlays/*.md` if present.

## Making decisions

Tickets leave gaps. Default to **deciding, then surfacing** in the PR body under `## Decisions taken without asking`.

Ask the human when:

- The call is **irreversible** (destructive migration, real email, prod data loss).
- It affects **non-code stakeholders** (pricing, legal, UX policy).
- It is **architectural and cross-cutting**.

## Test-fix-learn (every PR)

Non-negotiable, including one-line fixes.

### Phase 1 — First pass

Implement. Run the consumer's actual check/test/build commands from DEVELOPMENT (or the README). Do not assume a particular package manager. Open a PR with `## Summary`, `## Test plan`, and `## Decisions taken without asking` when you decided without asking.

### Phase 2 — Self-test

Pick the method that produces signal for **this** diff. UI: exercise the flows, including empty/error/permission states. No UI: unit/integration plus a cold read; queue a POST_MERGE_VERIFICATION entry with copy-pasteable commands. Fix what you find on the same branch.

### Phase 2.5 — Cranky

Run `/cranky` on the **latest SHA**. See [skills/cranky/SKILL.md](skills/cranky/SKILL.md).

- Holistic cranky is mandatory for logic, config, deploy, and schema diffs. Skip only for pure copy/style with no behavior change — and still run cranky if `/merge` is about to fire; `/merge` does not skip.
- The reviewer is **cold**: diff + file list + overlay/DNA paths. No author intent.
- Output: [docs/FORMAT.md](docs/FORMAT.md). `## VERDICT` is the merge bit.
- REQUEST CHANGES with CRIT or MAJ → fix → cranky the new SHA. Round-2/3 are normal.

### Phase 3 — Mistakes

If self-test or cranky found real bugs, append a **category** line to AGENT_MISTAKES (not a novel). If a runtime rule was taught, **propose** an INVARIANTS entry. Do not silently edit DNA.

### Phase 4 — Cleanup

Leave a clean tree. Kill servers and extra processes you started.

### Phase 5 — Post-merge

If you merge in-session, you own verification. Wait for deploy or CI as the consumer defines it. Run every POST_MERGE_VERIFICATION entry whose trigger has fired. A green pipeline is not a rendered page or a live fence.

## Cranky and merge

- `/merge` always runs cranky on the current head SHA first. See [skills/merge/SKILL.md](skills/merge/SKILL.md).
- Only override: the human types `/merge --skip-cranky` (or equivalent) and confirms.
- Banned rationalizations: docs-only, version bump, three-line change, "CI is green," "in a hurry," "cranky approved a similar PR."

## Cleanse

`/cleanse` is DNA hygiene. Shallow: DNA vs DNA. Deep: DNA vs code, plus AGENT_MISTAKES patterns → proposed guardrails. Human approves DNA edits. See [skills/cleanse/SKILL.md](skills/cleanse/SKILL.md).

## Guardrail changes

The human is the gatekeeper. To change DNA or this contract, propose the change and wait. Edit implementation to fit DNA, or get the guardrail changed first.

## Writing for the human

Lead with the outcome. Do not narrate the search. Mark verified vs inferred vs assumed. "Tests pass" is not "this works in prod."
