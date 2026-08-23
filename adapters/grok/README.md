# Grok adapter

Install copies `skills/*` to `.grok/skills/` and `.agents/skills/` (Grok scans both).

When spawning the holistic reviewer:

- `subagent_type`: `general-purpose`
- Prepend `persona.md` to the child prompt (Grok does not take a `persona=` argument on spawn)
- `description` starts with `[reviewer]`
- Do not pass `capability_mode: read-only` if the child must write a review file; keep it off product source via the prompt
- Do not pass the PR body

Canonical skills still live in `skills/`. Re-run install after pulling this pack.
