local Entity = require('__stdlib__/stdlib/entity/entity')

------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL CONSTANTS
------------------------------------------------------------------------------------------------------------------------------------------
local VARIATION_IDLE = 1
local VARIATION_WORKING = 2
local VARIATION_DISABLED = 3

------------------------------------------------------------------------------------------------------------------------------------------
-- PYLON POWER LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

local requires_power = {
    ["starcraft-robotics-facility"] = true,
    ["starcraft-observatory"] = true,
    ["starcraft-gateway"] = true,
    ["starcraft-cannon"] = true,
    ["starcraft-citadel"] = true,
    ["starcraft-cyber-core"] = true,
    ["starcraft-archives"] = true,
    ["starcraft-forge"] = true,
    ["starcraft-stargate"] = true,
    ["starcraft-fleet-beacon"] = true,
    ["starcraft-tribunal"] = true,
    ["starcraft-robotics-support-bay"] = true,
    ["starcraft-shield-battery"] = true
}

local powered_entities = {
    "starcraft-robotics-facility",
    "starcraft-observatory",
    "starcraft-gateway",
    "starcraft-cannon",
    "starcraft-citadel",
    "starcraft-cyber-core",
    "starcraft-archives",
    "starcraft-forge",
    "starcraft-stargate",
    "starcraft-fleet-beacon",
    "starcraft-tribunal",
    "starcraft-robotics-support-bay",
    "starcraft-shield-battery
}

-- TODO: Extend for Factorio tile sizes --
-- This matrix is based on the result of an algorithm in Starcraft that analyzes the (original) psi-field graphic.
-- The analysis is how the actual game computes which tiles are powered, we can re-do the analysis with
-- Factorio's tile granularity to improve the precision. For now this version is just coming from BWAPI.
local bPsiFieldMask = {
    { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 }
}

-- TODO: This algorithm is inefficient, taken from Starcraft and may need rewrite for Factorio scale. See below function notes.
local function IsCellPowered(surface, x, y, force)
    local pylons = surface.find_entities_filtered{
        name = "starcraft-pylon",
        force = force
    }

    for _, p in ipairs(pylons) do
        if math.abs(p.position.x - x) < 256*2 then
            if math.abs(p.position.y - y) < 160*2 then
                local x_off = ((x - p.position.x) / 2 + 256) / 32
                local y_off = ((y - p.position.y) / 2 + 160) / 32

                if bPsiFieldMask[y_off + 1][x_off + 1] == 1 then
                    return true
                end
            end
        end
    end
    return false
end

function IsCellPoweredForType(surface, type, x, y, force)
    if not requires_power[type] then
        return true
    end

    return IsCellPowered(surface, x, y, force)
end

-- TODO: do away with this
function RequestProtossPowerUpdate(surface)
    global.surface_data[surface.name].needs_power_update = true
end

-- TODO: Also incredibly inefficient. Taken from Starcraft.
-- 1. If we wanted *more* Protoss factions then it would be better to request power updates
--    by force and surface, since power update requests aren't relevant between different forces.
-- 2. Having pylons do a tile-based asignment would be more scalable, as it would eliminate these `find_entities` calls for the entire surface which
--    I assume is costly, especially doing a Pylon `find_entities` for *every single Protoss structure*.
--    Using the tile-data approach we'd only need to update data when pylons are created/destroyed, then can do O(1) lookups.
--    See Tile.set_data - http://afforess.github.io/Factorio-Stdlib/modules/Area.Tile.html
function UpdateProtossPowerGrid(surface)
    if not global.surface_data[surface.name].needs_power_update then
        return
    end

    local structures = surface.find_entities_filtered{
        name = powered_entities
    }

    for _, bldg in ipairs(structures) do
        -- TODO: Check extra associated data to determine whether the entity should be enabled again. Other mods might also disable things for various reasons.
        -- Those reasons may be unclear from our perspective but we can at least deduce whether or not it was set by us.
        if IsCellPowered(surface, bldg.position.x, bldg.position.y, bldg.force) then
            -- TODO: if it was previously disabled by us, then...
            bldg.active = true
            bldg.graphics_variation = VARIATION_IDLE
        else
            -- TODO: set data to indicate that we disabled it for being unpowered and not any other reason
            bldg.active = false
            bldg.graphics_variation = VARIATION_DISABLED
        end
    end

    global.surface_data[surface.name].needs_power_update = false
end

------------------------------------------------------------------------------------------------------------------------------------------
-- PROTOSS SHIELD LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

local shield_values = {
    ["starcraft-nexus"] = 750,
    ["starcraft-robotics-facility"] = 500,
    ["starcraft-pylon"] = 300,
    ["starcraft-assimilator"] = 450,
    ["starcraft-observatory"] = 250,
    ["starcraft-gateway"] = 500,
    ["starcraft-cannon"] = 100,
    ["starcraft-citadel"] = 450,
    ["starcraft-cyber-core"] = 500,
    ["starcraft-archives"] = 500,
    ["starcraft-forge"] = 500,
    ["starcraft-stargate"] = 600,
    ["starcraft-fleet-beacon"] = 500,
    ["starcraft-tribunal"] = 500,
    ["starcraft-robotics-support-bay"] = 450,
    ["starcraft-shield-battery"] = 200
}

-- TODO

-- Factorio doesn't support the concept of shields outside of equipment grids, so we'll have to implement it ourselves.
function InitShields(entity)
    local data = Entity.get_data(entity) or {}

    if shield_values[entity.name] ~= nil then
        data.max_shields = shield_values[entity.name]
        data.shields = data.max_shields
    end

    Entity.set_data(entity, data)
end


------------------------------------------------------------------------------------------------------------------------------------------
-- PROTOSS SHIELD BATTERY LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

-- TODO



------------------------------------------------------------------------------------------------------------------------------------------
-- PROTOSS ABILITIES LOGIC (CUnitPSpells.cpp)
------------------------------------------------------------------------------------------------------------------------------------------

-- TODO (prototypes are wack for now)

function CreatePsionicStorm(x, y)
end

function CreateDisruptionWeb(x, y)
end

function ApplyMaelstromGround(x, y, entity)
end

function ApplyStasisGround(x, y, entity)
end

-- Hallucination needs a new separate entity for all units, vehicles, and robots which gets its HP cut in half and deal zero damage.
-- This will be a pain in the ass to do?
function DispatchHallucinate(entity)
end

function DispatchCastMindControl(entity)
end

function DispatchCastFeedback(entity)
end

function DispatchRecall(entity)
end
