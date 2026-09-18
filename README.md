# Cranky Review 2.0

An AI-agnostic **agent operating system** you drop into a repo you already have. An agent takes a change from "describe it" to "merged, verified" with a real merge gate: **cranky review**.

It is a method pack, not a SaaS starter. No app skeleton, no database, no cloud vendor.

**This repository is private for now.** It is written as if it were already public (MIT, attribution, no secrets) so flipping visibility later is a GitHub setting, not a rewrite.

## Inspiration

The DNA / ledger / adversarial-review / `/cleanse` loop is inspired by [ulfaslak/saas_tmplt](https://github.com/ulfaslak/saas_tmplt) (Ulf Aslak). That repo bundles a SvelteKit SaaS skeleton with an opinionated Claude Code workflow. Cranky Review 2.0 takes the **workflow ideas**, not the app, and rewrites them as an AI-agnostic method you can drop into a repo you already have.

**Practice.** The merge-bit (`## VERDICT`), CRIT/MAJ/MIN/NIT taxonomy, counter-agent + holistic reviewer, and "no PR is too small" rule come from production use of cranky review on live systems. 2.0 is that gate plus saas_tmplt's closed loop (mistakes → invariants → cleanse).

See [NOTICE.md](NOTICE.md) and [docs/METHOD.md](docs/METHOD.md) for lineage. This is **not a fork**. Files here are original prose.

## What you get

1. **The contract** — [`AGENTS.md`](AGENTS.md). DNA, knowledge routing, test-fix-learn, "write facts in the repo not in private memory."
2. **The skills** — [`skills/cranky`](skills/cranky), [`skills/merge`](skills/merge), [`skills/cleanse`](skills/cleanse). [Agent Skills](https://agentskills.io) format. Works with Grok, Claude Code, Codex, Cursor, Copilot, Gemini CLI, and anything else that loads `SKILL.md`.
3. **The templates** — [`templates/AGENTS/`](templates/AGENTS/). Empty DNA + ledgers you copy into *your* repo and fill with *your* invariants.

## 60-second install

```bash
git clone https://github.com/gasantiago16/cranky-review.git
cd your-existing-repo
../cranky-review/scripts/install.sh .     # Windows: ..\cranky-review\scripts\install.ps1
```

Then:

- Fill `AGENTS/` (copied from templates if you had none).
- Write `AGENTS/overlays/overlay-<product>.md` (see [docs/OVERLAYS.md](docs/OVERLAYS.md)).
- Seed `AGENTS/DNA/INVARIANTS.md` from bugs you already paid for. Empty DNA means agents invent architecture.
- In any Agent-Skills-aware tool: `/cranky` before merge; `/merge` when CI is green.

Harness-specific discovery: [docs/INSTALL.md](docs/INSTALL.md).

## The gate

```markdown
## VERDICT
APPROVE | APPROVE WITH MINORS | REQUEST CHANGES
```

CRIT or MAJ → `REQUEST CHANGES` → fix → cranky again on the **latest SHA**. CI green is necessary, not sufficient. The only override is an explicit `/merge --skip-cranky` that the human confirms.

Full schema: [docs/FORMAT.md](docs/FORMAT.md).

## Status

Public MIT method pack. Not a SaaS app and not a trading bot. Install into a repo you already have; `/cranky` before merge.

## License

MIT. See [LICENSE](LICENSE) and [NOTICE.md](NOTICE.md).
