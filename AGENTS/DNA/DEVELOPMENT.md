# Development (this method pack)

```powershell
# refresh harness copies after editing skills/
.\scripts\install.ps1 -Target .
```

```bash
./scripts/install.sh .
```

There is no application test suite. "CI green" means: install script copies skills; markdown links resolve; cranky on the PR APPROVEs.

Ship: PR → cranky → merge to `main`. This GitHub repo is public; do not land secrets, trading P&L, or product internals.
