-- =====================================================================
--  Distortionz CalmAI Advanced · client.lua
-- =====================================================================
--
--  Worldwide AI calming system. Disables hostile behaviors at three
--  levels:
--    1. World population settings (game-wide flags)
--    2. Relationship groups (faction-level neutralization)
--    3. Per-ped attribute overrides (brute-force fallback)
--
--  All modules are toggleable in config.lua.
-- =====================================================================

local function Debug(msg)
    if Config.Debug then print(('[distortionz_calmaiadvance] %s'):format(msg)) end
end

-- ─── Relationship groups (used for blanket neutralization) ──────────

local CIVILIAN_GROUPS = {
    'AMBIENT_GANG_LOST',
    'AMBIENT_GANG_MEXICAN',
    'AMBIENT_GANG_FAMILY',
    'AMBIENT_GANG_BALLAS',
    'AMBIENT_GANG_MARABUNTE',
    'AMBIENT_GANG_CULT',
    'AMBIENT_GANG_SALVA',
    'AMBIENT_GANG_WEICHENG',
    'AMBIENT_GANG_HILLBILLY',
    'GANG_1', 'GANG_2', 'GANG_9', 'GANG_10',
    'CIVMALE',
    'CIVFEMALE',
    'DEALER',
    'HATES_PLAYER',
}

local ANIMAL_GROUPS = {
    'COUGAR',
    'SHARK',
    'HEN',
    'DEER',
    'BOAR',
    'RABBIT',
    'BIRD',
    'FISH',
    'COW',
    'COYOTE',
    'CAT',
    'CHIMP',
    'CHICKENHAWK',
    'CORMORANT',
    'CROW',
    'DOG',
    'CRAB',
    'DOLPHIN',
    'HUSKY',
    'HUMPBACK',
    'KILLERWHALE',
    'PIG',
    'PIGEON',
    'POODLE',
    'PUG',
    'RAT',
    'RETRIEVER',
    'ROTTWEILER',
    'SEAGULL',
    'SHEPHERD',
    'STINGRAY',
    'WESTY',
}

-- ─── World-level pacification ───────────────────────────────────────
-- These are PERSISTENT natives (set-and-forget). They were previously
-- inside the per-second loop, which is wasteful and obscured intent.
-- Now run once at boot + a 30s safety re-apply (in case another resource
-- resets random cop spawning).
--
-- Removed: SetAmbientVehicleRangeMultiplierThisFrame(0.0). That's a
-- ThisFrame native that needed a per-frame loop to function. Running it
-- once per second made it dead code, AND it was misnamed (controls
-- ambient *vehicle range*, not gunfire). qbx_density already manages
-- ambient vehicle density correctly — calmai shouldn't fight it.

local function ApplyWorldCalmFlags()
    -- gangShootouts toggle disables ambient cop spawning by name; native
    -- below is what actually does the suppression.
    if Config.Modules.gangShootouts then
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
    end
end

-- ─── Relationship neutralization ────────────────────────────────────

local function NeutralizeRelationships()
    local playerGroup = GetHashKey('PLAYER')

    local groupsToCalm = {}

    if Config.Modules.pedAggression then
        for _, g in ipairs(CIVILIAN_GROUPS) do
            groupsToCalm[#groupsToCalm + 1] = g
        end
    end

    if Config.Modules.animalAggression then
        for _, g in ipairs(ANIMAL_GROUPS) do
            groupsToCalm[#groupsToCalm + 1] = g
        end
    end

    for _, groupName in ipairs(groupsToCalm) do
        local groupHash = GetHashKey(groupName)
        -- Set them as Respect (0) toward the player so they won't attack
        SetRelationshipBetweenGroups(0, groupHash, playerGroup)
        SetRelationshipBetweenGroups(0, playerGroup, groupHash)
    end
end

-- ─── Per-ped attribute overrides ────────────────────────────────────

local function CalmPed(ped)
    if not DoesEntityExist(ped) or IsPedAPlayer(ped) or IsEntityDead(ped) then return end

    -- Block hostile decisions
    SetPedFleeAttributes(ped, 0, false)
    SetPedCombatAttributes(ped, 17, true)   -- always flee instead of fight (17 = AlwaysFlee)
    SetPedCombatAttributes(ped, 46, false)  -- can't fight armed peds (46 = WillScanForDeadPeds)
    SetPedCombatAttributes(ped, 5,  false)  -- can't use weapons (5 = CanUseCover)

    -- Strip combat ability
    SetPedAsEnemy(ped, false)
    SetPedCanRagdollFromPlayerImpact(ped, true)
    SetPedSuffersCriticalHits(ped, true)

    -- Block weapon use entirely
    DisablePedPainAudio(ped, true)
    RemoveAllPedWeapons(ped, true)
    SetPedDropsWeaponsWhenDead(ped, false)

    -- Road rage cleanup — don't let drivers leave their car after a crash
    if Config.Modules.roadRage and IsPedInAnyVehicle(ped, false) then
        SetPedConfigFlag(ped, 251, true)   -- DisableExitVehicle
        SetPedConfigFlag(ped, 252, true)   -- DisableExitVehicleOnCombat
        SetDriverAggressiveness(ped, 0.0)
        SetDriverAbility(ped, 1.0)
    end
end

-- ─── World-flag + relationship bootstrap (persistent — slow loop) ──
-- Persistent natives only need to be set once. We run them at boot then
-- re-apply every 30s as a safety net in case another resource resets
-- relationships or cop spawning. Far cheaper than calling them per-second
-- alongside the ped scan.

CreateThread(function()
    while true do
        ApplyWorldCalmFlags()
        NeutralizeRelationships()
        Wait(30000)
    end
end)

-- ─── Per-ped calm loop ──────────────────────────────────────────────
-- Iterates streamed peds within radius and applies attribute overrides.
-- Intentionally on its own thread so the heavy ped scan doesn't drag
-- the lightweight world flags above to the same cadence.

CreateThread(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local radius = Config.Tuning.radius

        for _, ped in ipairs(GetGamePool('CPed')) do
            if DoesEntityExist(ped) and not IsPedAPlayer(ped) then
                local pedCoords = GetEntityCoords(ped)
                if #(playerCoords - pedCoords) <= radius then
                    CalmPed(ped)
                end
            end
        end

        Wait(Config.Tuning.refreshIntervalMs)
    end
end)

-- ─── Lifecycle ──────────────────────────────────────────────────────

CreateThread(function()
    Wait(2000)
    Debug(('Started — radius: %sm, interval: %sms'):format(Config.Tuning.radius, Config.Tuning.refreshIntervalMs))
end)

-- ─── Reset relationships when resource stops ────────────────────────
-- Without this, the relationship overrides persist across resource
-- restarts and gangs/animals stay calm even if the script is stopped.

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName ~= GetCurrentResourceName() then return end

    local playerGroup = GetHashKey('PLAYER')

    -- Restore default hostile relationships
    for _, g in ipairs(CIVILIAN_GROUPS) do
        local groupHash = GetHashKey(g)
        SetRelationshipBetweenGroups(5, groupHash, playerGroup)  -- 5 = Hate
    end

    for _, g in ipairs(ANIMAL_GROUPS) do
        local groupHash = GetHashKey(g)
        -- Animals back to dislike (3) — most weren't hate-relationship by default
        SetRelationshipBetweenGroups(3, groupHash, playerGroup)
    end
end)
