# Overlay — method pack

Fences for changes to Cranky Review 2.0 itself.

1. Does this paste saas_tmplt (or any other third-party skill) verbatim?
2. Does this introduce a second VERDICT schema besides docs/FORMAT.md?
3. Does this add secrets, hostnames, product internals, or trading/ops war-story identifiers that would block going public?
4. Does `/merge` still require cranky on the latest SHA?
5. After a `skills/` edit, were `.agents/skills`, `.claude/skills`, and `.grok/skills` refreshed via install (or is this PR only touching canonical `skills/` with a note to run install)?
