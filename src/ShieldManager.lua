require("factorio_libs.EntitySet")

local math = require('__stdlib__/stdlib/utils/math')
local Entity = require('__stdlib__/stdlib/entity/entity')
local lo_data = require("__starcraft__/unit/lo")


local ShieldManager = {}
local shield_bar_updates = EntitySet:new("ShieldMgrUpdates")
local tracking_shield_entities = EntitySet:new("CUnitProtoss_ShieldEntities")

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

function ShieldManager.queue_update_shield_bar(entity)
    shield_bar_updates:insert(entity)
end

local function update_shield_bar(entity)
    local data = Entity.get_data(entity)

    local health_ratio = entity.get_health_ratio()
    local shield_ratio = ShieldManager.get_shield_ratio(entity)

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

function ShieldManager.update_shield_bars()
    for _, entity in shield_bar_updates:pairs() do
        if entity.valid then
            update_shield_bar(entity)
        end
    end
    shield_bar_updates:clear()
end

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
    ShieldManager.queue_update_shield_bar(entity)
end

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD TRACKING AND REGEN
------------------------------------------------------------------------------------------------------------------------------------------

function ShieldManager.register_shield_entity(entity)
    tracking_shield_entities:insert(entity)
end

function ShieldManager.unregister_shield_entity(entity)
    tracking_shield_entities:remove(entity)
    shield_bar_updates:remove(entity)
end

function ShieldManager.update_shield_entities()
    tracking_shield_entities:foreach(function(entity)
        -- TODO: Move to every other or every third update for performance?
        if entity.valid and ShieldManager.add_shields(entity, 0.01085) then
            ShieldManager.queue_update_shield_bar(entity)
        end
    end)
end

-- Factorio doesn't support the concept of shields outside of equipment grids, so we'll have to implement it ourselves.
function ShieldManager.init_shields(entity)
    if SHIELD_VALUES[entity.name] ~= nil then
        local data = Entity.get_data(entity) or {}

        if data.max_shields == nil then
            data.max_shields = SHIELD_VALUES[entity.name]
            data.shields = data.max_shields

            Entity.set_data(entity, data)
        end
        create_shield_bars(entity)
        ShieldManager.register_shield_entity(entity)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------
-- SHIELD API
------------------------------------------------------------------------------------------------------------------------------------------

function ShieldManager.get_shields(entity)
    local data = Entity.get_data(entity) or {}
    return data.shields or 0
end

function ShieldManager.max_shields(entity)
    local data = Entity.get_data(entity) or {}
    return data.max_shields or 0
end

function ShieldManager.add_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields and data.shields < data.max_shields then
        data.shields = math.clamp(data.shields + amount, 0, data.max_shields)
        Entity.set_data(entity, data)
        return true
    end
    return false
end

function ShieldManager.subtract_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields then
        data.shields = math.clamp(data.shields - amount, 0, data.max_shields)
        Entity.set_data(entity, data)
        return math.max(amount - data.shields, 0)
    end
    return 0
end

function ShieldManager.set_shields(entity, amount)
    local data = Entity.get_data(entity) or {}

    if data.max_shields then
        data.shields = math.clamp(amount, 0, data.max_shields)
        Entity.set_data(entity, data)
    end
end

function ShieldManager.get_shield_ratio(entity)
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

function ShieldManager.on_damaged(event)
    if not event.entity.valid then return end
    if not tracking_shield_entities:contains(event.entity) then return end

    if event.original_damage_amount <= 0 or ShieldManager.get_shields(event.entity) == 0 then
        ShieldManager.queue_update_shield_bar(event.entity)

        -- Enable the entity in case it's unpowered, so that it can die
        if event.entity.health == 0 then
            event.entity.active = true
        end
        return
    end

    local remaining_damage = ShieldManager.subtract_shields(event.entity, event.original_damage_amount or 0.5)
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

    if event.entity.valid then
        ShieldManager.queue_update_shield_bar(event.entity)
    end
end


return ShieldManager
