local CUnitProtoss = {}

local Entity = require('__stdlib__/stdlib/entity/entity')
local Position = require('__stdlib__/stdlib/area/position')
local Surface = require('__stdlib__/stdlib/area/surface')
local math = require('__stdlib__/stdlib/utils/math')
local table = require('__stdlib__/stdlib/utils/table')

local ForceTile = require('src.ForceTile')

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
    local data = Entity.get_data(entity) or {}

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

local tracking_shield_entities = {}
local function register_shield_entity(entity)
    tracking_shield_entities[entity] = true
end

local function unregister_shield_entity(entity)
    tracking_shield_entities[entity] = nil
end

local function register_all_shield_entities()
    local entities = Surface.find_all_entities{
        name = table.keys(shield_values)
    }

    for _, entity in ipairs(entities) do
        register_shield_entity(entity)
    end
end

local function update_shield_entities()
    for entity, _ in pairs(tracking_shield_entities) do
        if entity.valid and CUnitProtoss.add_shields(entity, 0.01085) then
            update_shield_bars(entity)
        end
    end
end

-- Factorio doesn't support the concept of shields outside of equipment grids, so we'll have to implement it ourselves.
local function init_shields(entity)
    if shield_values[entity.name] ~= nil then
        local data = Entity.get_data(entity) or {}

        data.max_shields = shield_values[entity.name]
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
    if event.original_damage_amount < 0 or CUnitProtoss.get_shields(event.entity) == 0 then
        update_shield_bars(event.entity)    -- TODO: Make this queued for on_update
        return
    end

    local remaining_damage = CUnitProtoss.subtract_shields(event.entity, event.original_damage_amount or 0.5)
    event.entity.health = event.entity.health + event.final_damage_amount
    if remaining_damage > 0 then
        event.entity.damage(remaining_damage, event.force, event.damage_type.name, event.cause)
    else
        update_shield_bars(event.entity)    -- TODO: Make this queued for on_update
    end
end

function CUnitProtoss.on_update()
    update_shield_entities()
end

function CUnitProtoss.on_load()
    register_all_shield_entities()
end


return CUnitProtoss
