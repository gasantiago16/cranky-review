# Verdict format

This file is the **single home** for the cranky output schema. Skills link here. Do not restate the schema in adapters.

The merge bit is the VERDICT line. Anything else is evidence.

## Required header

The reviewer's last output (and the saved review file, if any) must contain:

```markdown
## VERDICT
APPROVE
```

or

```markdown
## VERDICT
APPROVE WITH MINORS
```

or

```markdown
## VERDICT
REQUEST CHANGES
```

Exactly one of those three strings on the line after `## VERDICT`. No extra punctuation. No wrapping sentence.

| Verdict | Meaning | Merge? |
|---|---|---|
| `APPROVE` | No CRIT, no MAJ. MIN/NIT either absent or accepted as non-blocking. | Yes, if CI is green on this SHA. |
| `APPROVE WITH MINORS` | No CRIT, no MAJ. Open MIN items the human already agreed are deferrable. | Yes, only if the human already accepted that bar for this PR. |
| `REQUEST CHANGES` | Any CRIT or any MAJ, or a malformed review that could not be parsed. | No. Fix, push, cranky the new SHA. |

A prior APPROVE on an older SHA is invalid. Force-push invalidates it.

## Findings

After the verdict, list findings. Number within each severity (C1, M1, N1, T1).

```markdown
## Findings

### C1 — CRIT
- File: path/to/file.ext:LINE
- Failure: specific input or state → specific wrong output, crash, or data corruption
- Suggestion: how to fix (a sketch, not a patch)

### M1 — MAJ
- File: path/to/file.ext:LINE
- Failure: ...
- Suggestion: ...

### N1 — MIN
- File: path/to/file.ext:LINE
- Failure: ...
- Suggestion: ...

### T1 — NIT
- File: path/to/file.ext:LINE
- Note: ...
```

Severity labels are **CRIT**, **MAJ**, **MIN**, **NIT**. Do not use bug / suggestion / nit. Do not use GitHub `high` / `medium`.

| Label | Use when |
|---|---|
| **CRIT** | Will crash, corrupt data, bypass a safety fence, leak a secret, or ship a known-bad security boundary (including a version floor below a patch line). |
| **MAJ** | Wrong in a concrete scenario that can happen in production, but not immediately catastrophic. Race, missed enum consumer, adjacent feature desync. |
| **MIN** | Real issue, low blast radius, or a missing test for a path that is otherwise correct. |
| **NIT** | Taste, naming, comment quality. Never blocks merge by itself. |

## Concrete-failure bar

Every CRIT and MAJ **must** name:

1. The input, state, or ordering.
2. What goes wrong (wrong output, crash, corruption, leaked secret, fence bypass).
3. A `file:line` on the **new** side of the diff.

"Consider handling X" is not a finding. If you cannot construct the failing scenario, dig until you can or drop it.

MIN may use the same shape. NIT may use `- Note:` instead of `- Failure:`.

## Clean section (required)

```markdown
## What I tested but found clean
- <area you actually walked, and why it is clean>
```

This exists so silence is evidence, not laziness. If the section is empty, the review is incomplete — treat as malformed, not APPROVE.

## SHA pin

Record the reviewed commit:

```markdown
## SHA
<40-char hex>
```

`/merge` compares this to `headRefOid`. Mismatch → cranky again.

## Malformed reviews

If the orchestrator cannot find `## VERDICT` plus one of the three exact tokens, re-run the reviewer once with a format reminder. Second failure → `REQUEST CHANGES` (fail closed). Do not invent APPROVE.
