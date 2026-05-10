Config = {}

Config.Script = {
    name    = 'Distortionz CalmAI Advanced',
    version = '1.0.2',
}

Config.Debug = false

-- ─── Calm modules ────────────────────────────────────────────────────
-- Each toggle controls an independent layer of the AI calming system.
-- Disable any of these if you want certain behaviors to remain active.
Config.Modules = {
    -- Stops NPC peds from attacking, fighting, or fleeing
    pedAggression       = true,

    -- Stops animals (dogs, cougars, sharks, deer, etc.) from attacking
    animalAggression    = true,

    -- Stops scripted gang member shootouts in gang territories
    gangShootouts       = true,

    -- Stops drivers from honking, ramming, leaving cars to fight after collisions
    roadRage            = true,

    -- Stops random ambient gunfire / drive-bys baked into the GTA world
    ambientGunfire      = true,

    -- Stops cops from auto-engaging on minor infractions (kept moderate)
    civilianCopChases   = false,
}

-- ─── Tuning ─────────────────────────────────────────────────────────
Config.Tuning = {
    -- How often the calm logic runs (ms). 1000 is a good balance — lower
    -- = more aggressive but heavier on CPU.
    refreshIntervalMs = 1000,

    -- Apply calm logic to peds within this radius of each player.
    -- 250m is plenty for streamed peds. 500m+ is overkill.
    radius            = 250.0,
}

-- ─── Notify integration ─────────────────────────────────────────────
Config.Notify = {
    resource      = 'distortionz_notify',
    title         = 'CalmAI',
    defaultLength = 4000,
}

-- ─── Version checker ────────────────────────────────────────────────
Config.VersionCheck = {
    enabled     = true,
    checkOnStart = true,
    url         = 'https://raw.githubusercontent.com/Distortionzz/Distortionz_CalmAiAdvance/main/version.json',
}
Config.CurrentVersion = '1.0.2'
