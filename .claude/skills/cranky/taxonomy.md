# Taxonomy

Walk **every** category on every holistic cranky pass. Overlay questions run after this list, not instead of it. Findings still have to meet [docs/FORMAT.md](../../docs/FORMAT.md) (concrete failure, `file:line`).

## State-machine edges

Every status, role, and phase the diff touches — not one happy path and one error. If the diff **adds a value** to an enum or status field, grep every consumer that branches on that field. An allow-list of old values silently excludes the new one. A secondary lookup is not a substitute for the value's own branch. Mutation guards (`status === 'resolved'`) need a decision about the new state too.

## Permission edges

Each role at each boundary: every role in the system, unauthenticated, wrong tenant, revoked access, expired token. Confirm the new path is not reachable from a role the author stopped picturing.

## Empty / boundary

No rows, one row, many rows, max length, null/undefined/missing optional, whitespace-only, zero, negative, overflow.

## Concurrency and re-entry

Race every read-then-act sequence against a concurrent actor: a job, a retry, a second tab, duplicate submit, a webhook replay, a partial failure then retry. Sequences that are correct single-threaded are what single-actor tests cannot catch.

## Failure modes

Dependency down or slow, malformed payload, retries/replays, invalid data already in the store, live prod shapes that differ from fixtures. The gate you ran vs the gate that ships: dev server vs prod build, your shell vs the daemon, mocked client vs real one.

## Adjacent features

Anything else that reads or writes the same rows or fields. Counts, lists, and derived views must still agree.

## Duplicated hard-coded rosters

If the diff adds to or "fixes" a hard-coded list (allow-list, enum-to-label map, version floor, section roster), grep for the list's **members** to find sibling copies. Two "compute the same thing" helpers drift by exactly one entry. When **adding** a member, grep for a *sibling* member — the new name is absent from every list that needs it.

Version constraints are a roster. A floor below the real patch line is CRIT.

## A new secret, and every sink that could record it

Logger, reverse proxy, error messages that echo a body, job payloads, screenshots, fixtures. Treat each sink as a bug until it is shown not to write the secret.

## Prose is a claim

Every comment, docstring, DNA line, and piece of copy that describes behavior this diff changes is a claim. Grep for prose describing the old behavior. A comment that says "never X" with no code enforcing it is a finding, not documentation.

## Copied posture

Copying a sibling call site copies calibrations made for a different consequence. Re-derive error handling, strictness, and side effects from what **this** caller is for.

## Rendered result (when there is a UI)

A passing DOM or type assertion is not appearance. Check the rendered result at real content lengths and the narrowest supported viewport. Skip this category when the diff has no UI surface.

## Overlay

After the list above, walk every question in `AGENTS/overlays/*.md`. Fence violations are CRIT unless the overlay says otherwise.
