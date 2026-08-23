# Method

Why Cranky Review 2.0 exists, where the ideas came from, and how the loop closes.

## Lineage

Two sources, rewritten into one pack. **Not a fork of either.**

### saas_tmplt (inspiration)

[ulfaslak/saas_tmplt](https://github.com/ulfaslak/saas_tmplt) (Ulf Aslak) is a SvelteKit + Postgres SaaS starter that also bundles an agent workflow: `CLAUDE.md`, `AGENTS/DNA/`, a cold `adversarial-reviewer` subagent, `/cleanse`, and ledgers for mistakes, deferred work, and post-merge verification.

What we took **as ideas** (and rewrote):

- Architectural **DNA** with one kind of statement per file.
- A **cold** reviewer that is not told the author's story.
- A **concrete failure** bar, not "consider handling X."
- A taxonomy walk (state machines, permissions, races, adjacent features, duplicated rosters).
- Ledgers so the project learns: mistakes → invariants → cleanse.
- Test-fix-learn as a cycle, including verification after deploy.

What we did **not** take:

- The SvelteKit app, Drizzle schema, Docker/nginx/Terraform, or Hetzner deploy.
- Claude-only wiring (`Task` tool type names, `gtr`, `pnpm check` as the test story).
- Any source file verbatim. saas_tmplt had no LICENSE file when this was written; we do not copy it.

Credit lives in [README.md](../README.md), [NOTICE.md](../NOTICE.md), and this file.

### Production cranky (the merge bit)

On live trading and ops systems, "cranky review" meant:

- Per-bug **counter-agents** plus one **holistic** cranky reviewer.
- Severities **CRIT / MAJ / MIN / NIT**.
- A `## VERDICT` line that `/merge` can parse. No APPROVE, no merge.
- Fix-and-recurse until APPROVE. Round-2 and round-3 are normal.
- Pin the **latest SHA**. Force-push invalidates a prior APPROVE.
- CI green is necessary, not sufficient.
- No PR is too small. "It's a version bump" is how a CVE floor ships.

Example of the class (not a product war story for this file to specialize on): a three-line version-constraint change can sit below the actual patch line. CI stays green. Cranky is the pass that asks whether the constraint still means what the author thinks it means.

2.0 keeps that gate and adds saas_tmplt's closed loop: findings that teach a runtime rule become DNA, not a third copy of the same comment next month.

## Cold vs author-loop

The implementer cannot read their own diff cold. That anchoring is what hides the bug.

The holistic cranky child gets:

- The unified diff.
- The changed-file list.
- Overlay / DNA paths to read (not a paraphrase of them).

The holistic cranky child does **not** get:

- The ticket body.
- The author's "here's what I built and why."
- A happy-path walkthrough.

Counter-agents (optional) may be scoped to one subsystem. They still do not receive author intent. The holistic pass still runs; per-bug agents miss cross-cutting crashes.

## Taxonomy

The reviewer walks [taxonomy.md](../skills/cranky/taxonomy.md) every time, then any project overlay. Overlay findings use the same severities. A fence bypass in the overlay is CRIT.

## Knowledge routing

Anything true about how a **consumer** repo behaves is written in that repo (`AGENTS/DNA/`, ledgers), not in a coding agent's private memory. Private memory dies with the machine, the vendor, and the next hire.

This pack's own facts live in this repo's `AGENTS.md` and, after install, in `AGENTS/`.

## Test-fix-learn

See [AGENTS.md](../AGENTS.md) for the phase list. Short form:

1. Implement on a branch. Open a PR.
2. Self-test (the method that actually produces signal for *this* diff).
3. **Cranky** (Phase 2.5). Cold. Latest SHA.
4. Record mistake *categories* if self-test or cranky found real bugs.
5. Merge only on APPROVE + green CI.
6. Run post-merge verification entries whose triggers have fired.

## Go-public checklist

This repo starts **private**. Flip to public only when all of these are true:

- [ ] README Inspiration section still names and links `ulfaslak/saas_tmplt`.
- [ ] `LICENSE` is MIT; `NOTICE.md` is present.
- [ ] `git grep` is clean of secrets, VM IPs, hostnames, API keys, trading P&L, private memory paths, and product internals that should stay closed.
- [ ] No file is a verbatim copy of saas_tmplt source.
- [ ] This repo's own feature PRs were cranky-reviewed.
- [ ] `scripts/install.sh` and `scripts/install.ps1` work on a throwaway clone (Grok and Claude discovery paths).
- [ ] GitHub description and topics are ready (`agent-skills`, `code-review`, `agents-md`).

Then: GitHub Settings → Change repository visibility → Public. No second repository.
