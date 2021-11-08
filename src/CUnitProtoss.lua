local CUnitProtoss = {}

local Entity = require('__stdlib__/stdlib/entity/entity')
local Position = require('__stdlib__/stdlib/area/position')
local Surface = require('__stdlib__/stdlib/area/surface')
local math = require('__stdlib__/stdlib/utils/math')

local ForceTile = require('src.ForceTile')

local lo_data = require("__starcraft__/unit/lo")

------------------------------------------------------------------------------------------------------------------------------------------
-- LOCAL CONSTANTS
------------------------------------------------------------------------------------------------------------------------------------------
local VARIATION_IDLE = 1
local VARIATION_WORKING = 2
local VARIATION_DISABLED = 3

------------------------------------------------------------------------------------------------------------------------------------------
-- PYLON POWER LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

local POWER_KEY = "powered"
local PYLON_ENTITY_NAME = "starcraft-pylon"

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
    "starcraft-shield-battery"
}

-- Starcraft uses a matrix exactly like this internally, which is generated from IMG_PYLON_POWER_TOP,
-- using pixel hit detection and mirrored in all direction. This one was generated by hand by tracing the
-- algorithm at twice the granularity because one Factorio tile is half of a Starcraft tile.
local bPsiFieldMask = {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
    { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0 },
    { 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0 },
    { 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0 },
    { 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 },
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
}

-- width: 32 (+-16)
-- height: 20 (+-10)

local function IsCellPowered(surface, position, force)
    return (ForceTile.get_data(surface, force, POWER_KEY, position) or 0) > 0
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

    pos.x = pos.x - 16
    pos.y = pos.y - 10

    for psi_y = 1, 20 do
        for psi_x = 1, 32 do
            if bPsiFieldMask[psi_y][psi_x] == 1 then
                local target_pos = Position.add(pos, {x = psi_x, y = psi_y})
                local power = ForceTile.get_data(surface, force, POWER_KEY, target_pos) or 0

                power = power + change
                if power <= 0 then
                    power = nil
                end
                ForceTile.set_data(surface, force, POWER_KEY, target_pos, power)
            end
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
-- PROTOSS SHIELD LOGIC
------------------------------------------------------------------------------------------------------------------------------------------

local SHIELD_VALUES = {
    ["starcraft-nexus"] = 750,
    ["starcraft-nexus-warp-anchor"] = 750,
    ["starcraft-nexus-warp-fade"] = 750,
    ["starcraft-robotics-facility"] = 500,
    ["starcraft-robotics-facility-warp-anchor"] = 500,
    ["starcraft-robotics-facility-warp-fade"] = 500,
    ["starcraft-pylon"] = 300,
    ["starcraft-pylon-warp-anchor"] = 300,
    ["starcraft-pylon-warp-fade"] = 300,
    ["starcraft-assimilator"] = 450,
    ["starcraft-assimilator-warp-anchor"] = 450,
    ["starcraft-assimilator-warp-fade"] = 450,
    ["starcraft-observatory"] = 250,
    ["starcraft-observatory-warp-anchor"] = 250,
    ["starcraft-observatory-warp-fade"] = 250,
    ["starcraft-gateway"] = 500,
    ["starcraft-gateway-warp-anchor"] = 500,
    ["starcraft-gateway-warp-fade"] = 500,
    ["starcraft-cannon"] = 100,
    ["starcraft-cannon-warp-anchor"] = 100,
    ["starcraft-cannon-warp-fade"] = 100,
    ["starcraft-citadel"] = 450,
    ["starcraft-citadel-warp-anchor"] = 450,
    ["starcraft-citadel-warp-fade"] = 450,
    ["starcraft-cyber-core"] = 500,
    ["starcraft-cyber-core-warp-anchor"] = 500,
    ["starcraft-cyber-core-warp-fade"] = 500,
    ["starcraft-archives"] = 500,
    ["starcraft-archives-warp-anchor"] = 500,
    ["starcraft-archives-warp-fade"] = 500,
    ["starcraft-forge"] = 500,
    ["starcraft-forge-warp-anchor"] = 500,
    ["starcraft-forge-warp-fade"] = 500,
    ["starcraft-stargate"] = 600,
    ["starcraft-stargate-warp-anchor"] = 600,
    ["starcraft-stargate-warp-fade"] = 600,
    ["starcraft-fleet-beacon"] = 500,
    ["starcraft-fleet-beacon-warp-anchor"] = 500,
    ["starcraft-fleet-beacon-warp-fade"] = 500,
    ["starcraft-tribunal"] = 500,
    ["starcraft-tribunal-warp-anchor"] = 500,
    ["starcraft-tribunal-warp-fade"] = 500,
    ["starcraft-robotics-support-bay"] = 450,
    ["starcraft-robotics-support-bay-warp-anchor"] = 450,
    ["starcraft-robotics-support-bay-warp-fade"] = 450,
    ["starcraft-shield-battery"] = 200,
    ["starcraft-shield-battery-warp-anchor"] = 200,
    ["starcraft-shield-battery-warp-fade"] = 200
}

-- Default is 2 for omitted items
local SHIELD_SIZES = {
    ["starcraft-nexus"] = 3,
    ["starcraft-nexus-warp-anchor"] = 3,
    ["starcraft-nexus-warp-fade"] = 3
}

-- Copy of vertical offset from entity anim definitions to include in shield hit overlays
-- 0 if omitted
local SHIELD_VOFFSETS = {
    ["starcraft-nexus"] = -4/16,
    ["starcraft-nexus-warp-anchor"] = -4/16,
    ["starcraft-nexus-warp-fade"] = -4/16,
    ["starcraft-robotics-facility"] = -8/16,
    ["starcraft-robotics-facility-warp-anchor"] = -8/16,
    ["starcraft-robotics-facility-warp-fade"] = -8/16,
    ["starcraft-pylon"] = -11/16,
    ["starcraft-pylon-warp-anchor"] = -11/16,
    ["starcraft-pylon-warp-fade"] = -11/16,
    ["starcraft-observatory"] = -8/16,
    ["starcraft-observatory-warp-anchor"] = -8/16,
    ["starcraft-observatory-warp-fade"] = -8/16,
    ["starcraft-gateway"] = -11/16,
    ["starcraft-gateway-warp-anchor"] = -11/16,
    ["starcraft-gateway-warp-fade"] = -11/16,
    ["starcraft-cannon"] = -2/16,
    ["starcraft-cannon-warp-anchor"] = -2/16,
    ["starcraft-cannon-warp-fade"] = -2/16,
    ["starcraft-citadel"] = -13/16,
    ["starcraft-citadel-warp-anchor"] = -13/16,
    ["starcraft-citadel-warp-fade"] = -13/16,
    ["starcraft-cyber-core"] = -1/16,
    ["starcraft-cyber-core-warp-anchor"] = -1/16,
    ["starcraft-cyber-core-warp-fade"] = -1/16,
    ["starcraft-archives"] = -5/16,
    ["starcraft-archives-warp-anchor"] = -5/16,
    ["starcraft-archives-warp-fade"] = -5/16,
    ["starcraft-forge"] = -1/16,
    ["starcraft-forge-warp-anchor"] = -1/16,
    ["starcraft-forge-warp-fade"] = -1/16,
    ["starcraft-stargate"] = -16/16,
    ["starcraft-stargate-warp-anchor"] = -16/16,
    ["starcraft-stargate-warp-fade"] = -16/16,
    ["starcraft-fleet-beacon"] = -7/16,
    ["starcraft-fleet-beacon-warp-anchor"] = -7/16,
    ["starcraft-fleet-beacon-warp-fade"] = -7/16,
    ["starcraft-tribunal"] = -4/16,
    ["starcraft-tribunal-warp-anchor"] = -4/16,
    ["starcraft-tribunal-warp-fade"] = -4/16,
    ["starcraft-robotics-support-bay"] = -6/16,
    ["starcraft-robotics-support-bay-warp-anchor"] = -6/16,
    ["starcraft-robotics-support-bay-warp-fade"] = -6/16,
    ["starcraft-shield-battery"] = -3/16,
    ["starcraft-shield-battery-warp-anchor"] = -3/16,
    ["starcraft-shield-battery-warp-fade"] = -3/16
}

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD BARS
------------------------------------------------------------------------------------------------------------------------------------------

local BLACK_COLOR = {0, 0, 0}
local FADED_BLACK_COLOR = {0, 0, 0, 1/3}
local SHIELD_COLOR = {0, 115, 245}
local FADED_SHIELD_COLOR = {0, 115/4, 245/4, 1/3}
local UNFILLED_COLOR = {116, 116, 127}
local FADED_HEALTH_COLOR = {70/4, 225/4, 0, 1/3}

local function update_shield_bars(entity)
    if not entity.valid then return end
    local data = Entity.get_data(entity)
    if data == nil then return end

    local health_ratio = entity.get_health_ratio()
    local shield_ratio = CUnitProtoss.get_shield_ratio(entity)

    -- Set colours
    local should_show_faded_health = health_ratio == 1 and shield_ratio ~= 1
    rendering.set_visible(data.faded_health_bar_bg, should_show_faded_health)
    rendering.set_visible(data.faded_health_bar, should_show_faded_health)

    if shield_ratio == 1 then
        local should_show_faded_shields = health_ratio ~= 1
        rendering.set_visible(data.shield_bar_bg, should_show_faded_shields)
        rendering.set_visible(data.shield_bar_filled, should_show_faded_shields)
        rendering.set_visible(data.shield_bar_empty, should_show_faded_shields)

        if should_show_faded_shields then
            rendering.set_color(data.shield_bar_bg, FADED_BLACK_COLOR)
            rendering.set_color(data.shield_bar_filled, FADED_SHIELD_COLOR)
        end
    else
        rendering.set_visible(data.shield_bar_bg, true)
        rendering.set_visible(data.shield_bar_filled, true)
        rendering.set_visible(data.shield_bar_empty, true)
        rendering.set_color(data.shield_bar_bg, BLACK_COLOR)
        rendering.set_color(data.shield_bar_filled, SHIELD_COLOR)
    end

    -- Set bar progress
    local sel = entity.prototype.selection_box
    local num_boxes = math.floor((sel.right_bottom.x - sel.left_top.x) * 32 / 7)
    local filled_boxes = math.floor(num_boxes * shield_ratio)
    local mid_point = sel.left_top.x + 0.005 + filled_boxes * 7/32

    if filled_boxes == 0 then
        rendering.set_visible(data.shield_bar_filled, false)
    else
        rendering.set_to(data.shield_bar_filled, entity, {mid_point - 1/32, sel.right_bottom.y - 1/9 - 0.003})
    end

    if filled_boxes == num_boxes then
        rendering.set_visible(data.shield_bar_empty, false)
    else
        rendering.set_from(data.shield_bar_empty, entity, {mid_point + 1/32, sel.right_bottom.y - 1/9 - 0.003})
    end
end

-- TODO: Cache to prevent unnecessarily calling this for entities with full hp+shields etc
local function create_shield_bars(entity)
    local data = Entity.get_data(entity) or {}
    local sel = entity.prototype.selection_box
    local num_boxes = math.floor((sel.right_bottom.x - sel.left_top.x) * 32 / 7)
    local mid_point = sel.left_top.x + 0.005 + num_boxes * 7/32

    data.shield_bar_bg = rendering.draw_rectangle{
        color = BLACK_COLOR,
        filled = true,
        left_top = entity,
        left_top_offset = {sel.left_top.x + 0.005, sel.right_bottom.y - 7/32 - 0.001},
        right_bottom = entity,
        right_bottom_offset = {sel.left_top.x + 0.005 + num_boxes * 7/32, sel.right_bottom.y - 0.001},
        surface = entity.surface
    }

    data.shield_bar_filled = rendering.draw_line{
        color = SHIELD_COLOR,
        width = 5,
        gap_length = 2/32,
        dash_length = 5/32,
        from = entity,
        from_offset = {sel.left_top.x + 1/32, sel.right_bottom.y - 1/9 - 0.003},
        to = entity,
        to_offset = {mid_point - 1/32, sel.right_bottom.y - 1/9 - 0.003},
        surface = entity.surface
    }

    data.shield_bar_empty = rendering.draw_line{
        color = UNFILLED_COLOR,
        width = 5,
        gap_length = 2/32,
        dash_length = 5/32,
        from = entity,
        from_offset = {mid_point + 1/32, sel.right_bottom.y - 1/9 - 0.003},
        to = entity,
        to_offset = {sel.left_top.x + 0.005 + num_boxes * 7/32 - 1/32, sel.right_bottom.y - 1/9 - 0.003},
        surface = entity.surface
    }

    data.faded_health_bar_bg = rendering.draw_rectangle{
        color = FADED_BLACK_COLOR,
        filled = true,
        left_top = entity,
        left_top_offset = {sel.left_top.x + 0.005, sel.right_bottom.y - 0.001},
        right_bottom = entity,
        right_bottom_offset = {sel.left_top.x + 0.005 + num_boxes * 7/32, sel.right_bottom.y + 7/32 - 0.001},
        surface = entity.surface
    }

    data.faded_health_bar = rendering.draw_line{
        color = FADED_HEALTH_COLOR,
        width = 5,
        gap_length = 2/32,
        dash_length = 5/32,
        from = entity,
        from_offset = {sel.left_top.x + 1/32, sel.right_bottom.y + 1/9 + 0.003},
        to = entity,
        to_offset = {sel.left_top.x + 0.005 + num_boxes * 7/32 - 1/32, sel.right_bottom.y + 1/9 + 0.003},
        surface = entity.surface
    }

    Entity.set_data(entity, data)
    update_shield_bars(entity)
end

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD TRACKING AND REGEN
------------------------------------------------------------------------------------------------------------------------------------------

local function register_shield_entity(entity)
    global.tracking_shield_entities[entity.unit_number] = entity
end

local function unregister_shield_entity(entity)
    global.tracking_shield_entities[entity.unit_number] = nil
end

local function update_shield_entities()
    for _, entity in pairs(global.tracking_shield_entities) do
        if entity.valid and CUnitProtoss.add_shields(entity, 0.01085) then
            update_shield_bars(entity)
        end
    end
end

-- Factorio doesn't support the concept of shields outside of equipment grids, so we'll have to implement it ourselves.
local function init_shields(entity)
    if SHIELD_VALUES[entity.name] ~= nil then
        local data = Entity.get_data(entity) or {}

        data.max_shields = SHIELD_VALUES[entity.name]
        data.shields = data.max_shields

        Entity.set_data(entity, data)
        create_shield_bars(entity)
        register_shield_entity(entity)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD API
------------------------------------------------------------------------------------------------------------------------------------------

function CUnitProtoss.get_shields(entity)
    local data = Entity.get_data(entity) or {}
    return data.shields or 0
end

function CUnitProtoss.max_shields(entity)
    local data = Entity.get_data(entity) or {}
    return data.max_shields or 0
end

function CUnitProtoss.add_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields and data.shields < data.max_shields then
        data.shields = math.clamp(data.shields + amount, 0, data.max_shields)
        Entity.set_data(entity, data)
        return true
    end
    return false
end

function CUnitProtoss.subtract_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields then
        data.shields = math.clamp(data.shields - amount, 0, data.max_shields)
        Entity.set_data(entity, data)
        return math.max(amount - data.shields, 0)
    end
    return 0
end

function CUnitProtoss.set_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields then
        data.shields = math.clamp(amount, 0, data.max_shields)
        Entity.set_data(entity, data)
    end
end

function CUnitProtoss.get_shield_ratio(entity)
    local data = Entity.get_data(entity) or {}

    if data.max_shields then
        return data.shields / data.max_shields
    end
end

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD HIT OVERLAY
------------------------------------------------------------------------------------------------------------------------------------------

-- Gets the angle in radians between two positions
-- Note that Position.angle in Factorio stdlib is bugged and doesn't work (produces NaN)
local function get_positions_angle(pos1, pos2)
    local dx = pos2.x - pos1.x
    local dy = pos2.y - pos1.y

    local dist = math.sqrt(dx * dx + dy * dy)
    local angle_rad = math.atan2(dy / dist, dx / dist) + math.pi/2
    if angle_rad < 0 then
        angle_rad = angle_rad + 2 * math.pi
    end
    return angle_rad
end

-- Create a shield overlay on `entity` from the direction of `source`
-- NOTE: The actual algorithm uses the facing direction of the bullet, which doesn't appear doable
local function create_shield_overlay(entity, source)
    local source_direction = 0
    if source ~= nil then
        local angle_rad = get_positions_angle(entity.position, source.position)
        source_direction = (math.floor(angle_rad / (2 * math.pi) * 32) + 32) % 32 + 1
    end

    local shield_size = SHIELD_SIZES[entity.name] or 2
    local shield_pos = lo_data.get_shield_offset(shield_size, { orientation = source_direction })

    -- TODO: Precompute these divisions into lo.lua
    local x = entity.position.x + shield_pos[1] / 16
    local y = entity.position.y + shield_pos[2] / 16 + (SHIELD_VOFFSETS[entity.name] or 0)
    entity.surface.create_trivial_smoke{
        -- NOTE: Not a bug, Starcraft only uses the up-facing shield, whoops
        name = "starcraft-shield-hit-1",
        position = { x, y }
    }
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
    init_shields(entity)
    AddPsiField(entity.surface, entity.position, entity.force)
end

function CUnitProtoss.on_powered_bldg_created(entity)
    init_shields(entity)
    UpdateProtossPowerSingle(entity)
end

function CUnitProtoss.on_bldg_created(entity)
    init_shields(entity)
end

function CUnitProtoss.on_bldg_destroyed(entity)
    unregister_shield_entity(entity)
    Entity.set_data(entity, nil)
end

function CUnitProtoss.on_damaged(event)
    if global.tracking_shield_entities[event.entity.unit_number] == nil then return end
    if not event.entity.valid then return end

    if event.original_damage_amount <= 0 or CUnitProtoss.get_shields(event.entity) == 0 then
        update_shield_bars(event.entity)    -- TODO: Make this queued for on_update

        -- Enable the entity in case it's unpowered, so that it can die
        if event.entity.health == 0 then
            event.entity.active = true
        end
        return
    end

    local remaining_damage = CUnitProtoss.subtract_shields(event.entity, event.original_damage_amount or 0.5)
    if remaining_damage == 0 then
        create_shield_overlay(event.entity, event.cause)
    end

    event.entity.health = event.entity.health + event.final_damage_amount
    if remaining_damage >= 0 then
        if not event.damage_type then
            event.entity.damage(remaining_damage, event.force)
        elseif not event.cause then
            event.entity.damage(remaining_damage, event.force, event.damage_type.name)
        else
            event.entity.damage(remaining_damage, event.force, event.damage_type.name, event.cause)
        end
    end

    update_shield_bars(event.entity)    -- TODO: Make this queued for on_update
end

function CUnitProtoss.on_init()
    global.tracking_shield_entities = {}
end

function CUnitProtoss.on_update()
    update_shield_entities()
end


return CUnitProtoss
