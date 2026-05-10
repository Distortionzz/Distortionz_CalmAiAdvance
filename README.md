# Distortionz CalmAI Advanced

> Disables worldwide AI ped aggression, animal hostility, gang shootouts, and road rage for a calmer roleplay environment. Toggleable per-module.

![FiveM](https://img.shields.io/badge/FiveM-cerulean-yellow?style=flat-square&labelColor=181b20)
![Qbox](https://img.shields.io/badge/Qbox-required-red?style=flat-square&labelColor=dfb317)
![License](https://img.shields.io/badge/License-MIT-brightgreen?style=flat-square)
![Version](https://img.shields.io/github/v/release/Distortionzz/Distortionz_CalmAiAdvance?style=flat-square&color=d4aa62&label=version)

---

## Overview

Three-layer pacification system for ambient world behavior. Disables hostile NPC reactions across civilians, gangs, animals, and drivers without removing peds from the world. Set-and-forget — no in-game UI, all behavior driven by config toggles.

## Features

- **World-level flags** — disables random NPC cop spawning
- **Relationship neutralization** — civilians, gangs, animals all set to neutral toward player
- **Per-ped attribute overrides** — flee instead of fight, no weapon use, no exiting vehicles in road rage
- **Toggleable modules** — pedAggression / animalAggression / gangShootouts / roadRage / ambientGunfire
- **Auto-restore** — hostile defaults re-applied on resource stop
- **Lightweight** — bootstrap once + 30s safety re-apply, ped scan on configurable interval

## Dependencies

| Resource | Required | Purpose |
|---|---|---|
| `qbx_core` | yes | Player context |
| `ox_lib` | yes | Notify fallback |

## Installation

```cfg
ensure distortionz_calmaiadvance
```

## Configuration

See [`config.lua`](config.lua) for module toggles and tuning (refresh interval, pacification radius).

## Credits

- **Author:** Distortionz
- **Framework:** [Qbox Project](https://github.com/Qbox-project)

## License

MIT — see [LICENSE](LICENSE).
