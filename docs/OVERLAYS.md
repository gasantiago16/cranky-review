# Overlays

A cranky overlay is a **project threat model** the cold reviewer reads in addition to the generic taxonomy. Generic cranky without an overlay is valid. Overlays are how a consumer attaches fences the method pack cannot know (paper-only trading, fidelity modes, rsync excludes, multi-tenant org isolation).

## Where it lives

In the **consumer** repo, after install:

```
AGENTS/overlays/overlay-<product>.md
```

Multiple overlays are allowed. The cranky orchestrator loads every `AGENTS/overlays/*.md` it finds, plus `AGENTS/DNA/INVARIANTS.md` if present.

This method pack ships:

- [`templates/AGENTS/overlays/overlay.template.md`](../templates/AGENTS/overlays/overlay.template.md) — copy and fill.
- [`examples/overlay-production-vm.md`](../examples/overlay-production-vm.md) — generic VM/deploy class. No product names, no IPs, no secrets.

## What belongs in an overlay

Checklist questions the reviewer must answer **in this product's language**. Each question should be answerable CRIT / MAJ / clean.

Good overlay questions:

- Can this write a side effect we treat as irreversible (money, email to real users, prod data delete)?
- Can this bypass the safety fence the rest of the system assumes?
- Can this destroy secrets or the file that holds them?
- Can deploy / sync delete something the running system needs?
- Does a failed deploy still claim success (SHA written too early, healthcheck too weak)?
- Are version floors actually at the patch line they claim?

Bad overlay content:

- Author intent for a specific PR.
- Secrets, hostnames, account numbers.
- A second copy of [taxonomy.md](../skills/cranky/taxonomy.md).

## Severity in overlays

If the overlay says "this is a fence," violating it is **CRIT** unless the overlay says otherwise. Do not downgrade a fence to MIN because the rest of the diff is tidy.

## Empty DNA

Install copies empty INVARIANTS on purpose. **Seed them from bugs you already paid for** before you run cranky as a merge gate on feature work. Empty DNA trains the agent to invent architecture. Overlay questions plus two or three earned invariants beat a blank philosophy file.
