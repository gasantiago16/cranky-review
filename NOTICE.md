Cranky Review 2.0
Copyright (c) 2026 gasantiago16

This project is original work released under the MIT License (see LICENSE).

Inspiration
-----------
The DNA / ledger / adversarial-review / cleanse loop is inspired by:

  saas_tmplt
  https://github.com/ulfaslak/saas_tmplt
  Author: Ulf Aslak (@ulfaslak)

That repository bundles a SvelteKit SaaS skeleton with an opinionated
Claude Code agent workflow. Cranky Review 2.0 takes the workflow *ideas*
(architectural DNA, a cold reviewer, a cleanse pass, and learning ledgers)
and rewrites them as an AI-agnostic method pack. It does not include the
SvelteKit application, deploy stack, or Claude-only wiring.

saas_tmplt did not publish a LICENSE file at the time this project was
written. This repository does not copy that source. Attribution here is
courtesy, not a claim that saas_tmplt is licensed for reuse.

The merge-gate practice (CRIT / MAJ / MIN / NIT, ## VERDICT, counter-agent
plus holistic reviewer, "no PR is too small") comes from production use of
cranky review on live systems. That practice is documented in docs/METHOD.md.
