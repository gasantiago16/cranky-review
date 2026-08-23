# Overlay example — production VM + git deploy

Generic class, not a real product. Copy into `AGENTS/overlays/` and rewrite the questions in your language. No hostnames, no secrets.

Use this shape when production is a VM (or similar) whose tree is updated by rsync/SSH/CI, secrets live only on the box, and "which SHA is live" is a file the deploy job writes.

## Fences (CRIT if violated)

1. Can this write a side effect we treat as irreversible on the live box?
2. Can this bypass a paper-only / dry-run / "not live" fence the rest of the system assumes still holds?
3. Can deploy sync **delete** secrets, the live-SHA marker, or data directories that rsync must exclude?
4. Is the live-SHA marker written **before** health is proven (failed deploy still looks current)?
5. Does any log, error payload, or fixture print a secret?
6. If the box was hotfixed ahead of git, does this change overwrite it without a reconcile PR?

## Clean if

- Sync exclude list still covers secrets, data, and deploy markers.
- Marker is written only after the health command the overlay names.
- CI still asserts the fence (paper-only, etc.) this product claims.
