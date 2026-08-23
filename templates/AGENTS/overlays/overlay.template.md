# Overlay — <product>

Threat-model questions for cranky on this repo. Fence violations are CRIT.

Replace the angle-bracket section and the questions with yours. Delete questions that do not apply. Do not put secrets, hostnames, or author intent here.

## Fences

1. Can this write an irreversible side effect (money, real email, prod delete)?
2. Can this bypass the safety fence the rest of the system assumes?
3. Can this destroy secrets or the file that holds them?
4. Can deploy/sync delete something the running process needs?
5. Does a failed deploy still claim success (marker written too early, healthcheck too weak)?
6. Are version floors actually at the patch line they claim?

## Clean if

- <what "safe" looks like for this product>
