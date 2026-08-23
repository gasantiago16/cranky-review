# Contributing

This repo is a method pack. Canonical skills live in `skills/`. Vendor trees under `.agents/`, `.claude/`, and `.grok/` are **install output**. After you edit `skills/`, run:

```powershell
.\scripts\install.ps1 -Target .
```

or

```bash
./scripts/install.sh .
```

and commit the refreshed copies.

## Rules

- Original prose only. Do not paste [saas_tmplt](https://github.com/ulfaslak/saas_tmplt) source. Credit stays in README, NOTICE, and docs/METHOD.md.
- One home per fact. Verdict schema lives in `docs/FORMAT.md`. Taxonomy lives in `skills/cranky/taxonomy.md`. Adapters are pointers.
- Do not put secrets, hostnames, or product internals in this repository. It will go public.
- Change DNA/taxonomy/FORMAT via PR. Run `/cranky` on that PR.

## PR shape

`## Summary`, `## Test plan`. If you decided without asking, `## Decisions taken without asking`. `/merge` requires cranky APPROVE on the latest SHA once the cranky skill exists on the branch.
