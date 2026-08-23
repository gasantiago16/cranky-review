# Architecture (this method pack)

```
skills/           canonical Agent Skills (source of truth)
docs/             FORMAT, METHOD, INSTALL, OVERLAYS
templates/AGENTS/ empty DNA + ledgers for consumers
adapters/         thin pointers per harness
scripts/          install.sh / install.ps1
examples/         generic overlays, no secrets
AGENTS/           this pack's own DNA (dogfood)
```

After `scripts/install.ps1 -Target .`, copies also exist under `.agents/skills`, `.claude/skills`, `.grok/skills`.
