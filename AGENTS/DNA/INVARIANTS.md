# Invariants (this method pack)

Earned rules for Cranky Review 2.0 itself.

### The merge bit is the VERDICT line
**Mechanism:** `/merge` parses `## VERDICT` plus exactly `APPROVE` or `APPROVE WITH MINORS`. Other prose is not a gate.
**Incident:** Skip-rationalizations shipped a version floor below the real patch line when merge did not require a parseable verdict.

### Holistic cranky is cold
**Mechanism:** Child prompt is diff + file list + overlay/DNA paths. PR body and author summary are forbidden.
**Incident:** Author-context review missed cross-cutting failures that a fresh session caught.

### FORMAT.md is the only schema home
**Mechanism:** Skills and adapters link to `docs/FORMAT.md`. They do not restate the token list except persona.md, which must stay in lockstep.
**Incident:** Duplicate schemas drift (bug/suggestion/nit vs CRIT/MAJ/MIN/NIT).

### No saas_tmplt source
**Mechanism:** This pack rewrites ideas; NOTICE.md credits the inspiration. Verbatim copies are a defect.
**Incident:** saas_tmplt published no LICENSE; copying it would be infringement dressed up as a fork.

### Latest SHA or it does not count
**Mechanism:** Review records `## SHA`. `/merge` compares to `headRefOid`.
**Incident:** Approving then force-pushing left merge looking at a different tree.
