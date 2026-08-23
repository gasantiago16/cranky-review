# Post-merge verification

No production app. After merge to `main`:

### Confirm GitHub has the tree
**Trigger:** immediately after push/merge
**Steps:** `gh repo view gasantiago16/cranky-review --json visibility,url` and `git ls-files` locally matches origin/main.
**Success:** `visibility` is `PRIVATE`; README on GitHub shows the Inspiration section.
**On failure:** push was skipped or landed on the wrong remote.

---

## Entries

*(none queued beyond the standing check above)*
