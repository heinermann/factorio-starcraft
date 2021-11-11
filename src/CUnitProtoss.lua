local Entity = require('__stdlib__/stdlib/entity/entity')
local Position = require('__stdlib__/stdlib/area/position')

require('factorio_libs.ForceTileData')
local ShieldManager = require("ShieldManager")


local CUnitProtoss = {}
local powered_tiles = ForceTileData:new("PylonPower")

------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL CONSTANTS
------------------------------------------------------------------------------------------------------------------------------------------
local VARIATION_IDLE = 1
local VARIATION_WORKING = 2
local VARIATION_DISABLED = 3

------------------------------------------------------------------------------------------------------------------------------------------
-- PYLON POWER LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

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
    "starcraft-shield-battery"
}

-- Higher performance of the psi-field mask for the sake of the algorithm
local bPsiFieldRange = {
    { 12, 21 },
    { 9, 24 },
    { 6, 27 },
    { 5, 28 },
    { 4, 29 },
    { 3, 30 },
    { 2, 31 },
    { 2, 31 },
    { 1, 32 },
    { 1, 32 },
    { 1, 32 },
    { 1, 32 },
    { 2, 31 },
    { 2, 31 },
    { 3, 30 },
    { 4, 29 },
    { 5, 28 },
    { 6, 27 },
    { 9, 24 },
    { 12, 21 }
}

-- width: 32 (+-16)
-- height: 20 (+-10)

local function IsCellPowered(surface, position, force)
    return (powered_tiles:get_data(surface, force, position) or 0) > 0
end

local function UpdateProtossPowerSingle(entity)
    -- TODO: Check extra associated data to determine whether the entity should be enabled again. Other mods might also disable things for various reasons.
    -- Those reasons may be unclear from our perspective but we can at least deduce whether or not it was set by us.
    if IsCellPowered(entity.surface, entity.position, entity.force) then
        -- TODO: if it was previously disabled by us, then...
        entity.active = true
        entity.graphics_variation = VARIATION_IDLE
    else
        -- TODO: set data to indicate that we disabled it for being unpowered and not any other reason
        entity.active = false
        entity.graphics_variation = VARIATION_DISABLED
    end
end

local function UpdateProtossPower(surface, force, area)
    local structures = surface.find_entities_filtered{
        area = area,
        name = powered_entities,
        force = force
    }

    for _, bldg in ipairs(structures) do
        UpdateProtossPowerSingle(bldg)
    end
end

local function ModifyPsiField(surface, position, force, change)
    local pos = Position.floor(position)

    -- TODO: This might be incorrect because of 1-based indexing
    pos.x = pos.x - 16
    pos.y = pos.y - 10

    for psi_y = 1, 20 do
        local x_range = bPsiFieldRange[psi_y]
        for psi_x = x_range[1], x_range[2] do
            local target_pos = Position.add(pos, {x = psi_x, y = psi_y})
            local power = powered_tiles:get_data(surface, force, target_pos) or 0

            power = power + change
            if power <= 0 then
                power = nil
            end
            powered_tiles:set_data(surface, force, target_pos, power)
        end
    end

    UpdateProtossPower(surface, force, {pos, {pos.x + 32, pos.y + 20}})
end

local function AddPsiField(surface, position, force)
    ModifyPsiField(surface, position, force, 1)
end

local function RemovePsiField(surface, position, force)
    ModifyPsiField(surface, position, force, -1)
end

------------------------------------------------------------------------------------------------------------------------------------------
-- PROTOSS SHIELD BATTERY LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

-- TODO



------------------------------------------------------------------------------------------------------------------------------------------
-- PROTOSS ABILITIES LOGIC (CUnitPSpells.cpp)
------------------------------------------------------------------------------------------------------------------------------------------

-- TODO (prototypes are wack for now)

local function CreatePsionicStorm(x, y)
end

local function CreateDisruptionWeb(x, y)
end

local function ApplyMaelstromGround(x, y, entity)
end

local function ApplyStasisGround(x, y, entity)
end

-- Hallucination needs a new separate entity for all units, vehicles, and robots which gets its HP cut in half and deal zero damage.
-- This will be a pain in the ass to do?
local function DispatchHallucinate(entity)
end

local function DispatchCastMindControl(entity)
end

local function DispatchCastFeedback(entity)
end

local function DispatchRecall(entity)
end

------------------------------------------------------------------------------------------------------------------------------------------
-- Callback Logic
------------------------------------------------------------------------------------------------------------------------------------------
function CUnitProtoss.on_pylon_destroyed(entity)
    RemovePsiField(entity.surface, entity.position, entity.force)
    CUnitProtoss.on_bldg_destroyed(entity)
end

function CUnitProtoss.on_pylon_created(entity)
    ShieldManager.init_shields(entity)
    AddPsiField(entity.surface, entity.position, entity.force)
end

function CUnitProtoss.on_powered_bldg_created(entity)
    ShieldManager.init_shields(entity)
    UpdateProtossPowerSingle(entity)
end

function CUnitProtoss.on_bldg_created(entity)
    ShieldManager.init_shields(entity)
end

function CUnitProtoss.on_bldg_destroyed(entity)
    ShieldManager.unregister_shield_entity(entity)
    Entity.set_data(entity, nil)
end

function CUnitProtoss.on_update()
    ShieldManager.update_shield_entities()
    ShieldManager.update_shield_bars()
end


return CUnitProtoss
