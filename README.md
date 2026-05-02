# 🕊️🟡 Distortionz CalmAI Advanced

**Worldwide AI pacification system for FiveM / Qbox.**
A polished, feature-rich backend script that disables NPC aggression, animal hostility, gang shootouts, road rage, and ambient gunfire — giving your roleplay server a calmer, more cinematic atmosphere where players control the action, not the AI.

---

## ✨ Features

### 🛡️ Three-Layer Pacification
This isn't just a "set ped attribute" script. It calms hostile AI at three independent layers for maximum reliability:

**Layer 1 — World Flags ⚙️**
Disables ambient vehicle aggression and scripted gang shootout spawns at the engine level.

**Layer 2 — Relationship Groups 🤝**
Overrides game-wide relationships between the PLAYER group and 30+ civilian gangs / 25+ animal types. Hostile AI literally cannot decide to attack — the relationship is forcibly set to "Respect."

**Layer 3 — Per-Ped Attribute Overrides 🎯**
For every ped within 250m of any player:
- 🏃 Flee attributes neutralized
- ⚔️ Combat attribute 17 enabled (`AlwaysFlee` instead of fight)
- 🔫 All weapons stripped from ped inventory
- 🚗 Road rage drivers locked into their vehicle (no exit-and-fight)
- 🎚️ Driver aggression set to 0

### 🎚️ Modular Toggle System
Disable any module from `config.lua` — granular control per behavior:

| Module | Default | What it does |
|--------|---------|--------------|
| 🧍 `pedAggression` | ✅ ON | Stops NPCs from attacking, fighting, or fleeing |
| 🐺 `animalAggression` | ✅ ON | Stops dogs, cougars, sharks, deer, etc. from attacking |
| 🔫 `gangShootouts` | ✅ ON | Stops scripted gang shootouts in territories |
| 🚗 `roadRage` | ✅ ON | Stops drivers from honking, ramming, fighting after crashes |
| 💥 `ambientGunfire` | ✅ ON | Stops random world gunshots and drive-bys |
| 🚓 `civilianCopChases` | ❌ OFF | Cop AI stays untouched (kept moderate by default) |

### 🧹 Auto-Cleanup
If you ever stop the resource, **all relationship overrides automatically revert to hostile defaults** — no permanent state changes. Restart-safe and rollback-friendly.

### ⚙️ Performance Optimized
- 🔄 1-second refresh interval (configurable)
- 🎯 250m radius per player — only streamed peds get touched
- 🪶 Lightweight: zero NUI, zero database calls, zero networking overhead
- 🧠 Smart pool iteration — skips player peds and dead entities

### 🧾 Standardized Version Checker
- 📡 GitHub `version.json` polling on resource start
- 🔍 HTML-response detection (catches misconfigured URLs)
- 🆔 Custom User-Agent (avoids GitHub rate limits)
- 🟢 Color-coded console output

---

## 📦 Resource Name

```
distortionz_calmaiadvance
```

## 🛠 Installation

> ⚠️ **REQUIRED:** This script conflicts with `qbx_density` (which has its own basic AI calming layer). You must **stop or remove `qbx_density`** before using CalmAI Advanced, or the relationship overrides will be fought every frame.
>
> In your `server.cfg`, comment out or delete:
> ```cfg
> # ensure qbx_density
> ```

1. 📥 Drop the folder into your `resources/` folder
2. ⚙️ Open `config.lua` and tune:
   - `Config.Modules` — toggle individual calm layers
   - `Config.Tuning.refreshIntervalMs` — how often calm logic runs
   - `Config.Tuning.radius` — how far the per-ped overrides apply
3. 📝 Add to your `server.cfg`:
   ```cfg
   ensure distortionz_calmaiadvance
   ```
4. 🔄 Restart your server

## 🧩 Dependencies

- 🟦 [`qbx_core`](https://github.com/Qbox-project/qbx_core)
- 🛠️ [`ox_lib`](https://github.com/overextended/ox_lib)

## ⚙️ Configuration Highlights

```lua
Config.Modules = {
    pedAggression       = true,
    animalAggression    = true,
    gangShootouts       = true,
    roadRage            = true,
    ambientGunfire      = true,
    civilianCopChases   = false,  -- leave cops alone by default
}

Config.Tuning = {
    refreshIntervalMs = 1000,  -- 1 second pulse
    radius            = 250.0, -- 250m streamed-ped range
}
```

## 🎬 What Players Experience

### 😎 Before
- Walk past Lost MC clubhouse → instant gunfight
- Brush a Ballas car → 4-way street brawl
- Hit a cougar in Paleto Forest → mauled to death
- Driver clips your bumper → leaves car, swings fists

### 🕊️ After
- Walk past gangs → they stay seated, no aggression
- Bump cars on the street → drivers shrug it off
- Wildlife minds its own business
- World feels like a proper RP backdrop instead of GTA Online chaos

## 📝 Changelog

### v1.0.0
- 🎉 Initial release
- 🕊️ Three-layer pacification: world flags, relationship groups, per-ped overrides
- 🎚️ 6 toggleable modules
- 🧹 Auto-restore on resource stop
- 🐾 30+ civilian gangs and 25+ animal types neutralized

---

## 📜 License

MIT — see `LICENSE`.

---

**Built with 🟡 by Distortionz** · Part of the [Distortionz RP](https://github.com/Distortionzz) script lineup
