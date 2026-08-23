# Post-merge verification

Checks whose correctness can only be observed against the live system. Queued in the same PR that ships the change. Run by an agent after the trigger fires, not by hoping CI was enough.

Human-only steps belong in HUMAN_TODO.

## Entry shape (H3)

- **PR** — URL
- **Summary** — one sentence
- **Trigger** — when this becomes runnable
- **Steps** — exact commands (no "check the logs")
- **Success criteria** — what passing looks like
- **On failure** — where to look; fix forward; do not delete the entry until the fix is verified

Remove the entry when success criteria are met. Remove after ~30 days with no trigger and a one-line explanation.

---

## Entries

*(No entries yet.)*
