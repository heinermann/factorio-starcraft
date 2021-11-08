require("factorio_libs.UpdateManager")
local table = require('__stdlib__/stdlib/utils/table')
local Entity = require('__stdlib__/stdlib/entity/entity')

local CUnitPBuild = {}
local update_tracker = UpdateManager:new("CUnitPBuild")

local entity_progress_table = {
    ["starcraft-nexus-warp-anchor"] = "starcraft-nexus-warp-fade",
    ["starcraft-nexus-warp-fade"] = "starcraft-nexus",
    ["starcraft-robotics-facility-warp-anchor"] = "starcraft-robotics-facility-warp-fade",
    ["starcraft-robotics-facility-warp-fade"] = "starcraft-robotics-facility",
    ["starcraft-pylon-warp-anchor"] = "starcraft-pylon-warp-fade",
    ["starcraft-pylon-warp-fade"] = "starcraft-pylon",
    ["starcraft-assimilator-warp-anchor"] = "starcraft-assimilator-warp-fade",
    ["starcraft-assimilator-warp-fade"] = "starcraft-assimilator",
    ["starcraft-observatory-warp-anchor"] = "starcraft-observatory-warp-fade",
    ["starcraft-observatory-warp-fade"] = "starcraft-observatory",
    ["starcraft-gateway-warp-anchor"] = "starcraft-gateway-warp-fade",
    ["starcraft-gateway-warp-fade"] = "starcraft-gateway",
    ["starcraft-cannon-warp-anchor"] = "starcraft-cannon-warp-fade",
    ["starcraft-cannon-warp-fade"] = "starcraft-cannon",
    ["starcraft-citadel-warp-anchor"] = "starcraft-citadel-warp-fade",
    ["starcraft-citadel-warp-fade"] = "starcraft-citadel",
    ["starcraft-cyber-core-warp-anchor"] = "starcraft-cyber-core-warp-fade",
    ["starcraft-cyber-core-warp-fade"] = "starcraft-cyber-core",
    ["starcraft-archives-warp-anchor"] = "starcraft-archives-warp-fade",
    ["starcraft-archives-warp-fade"] = "starcraft-archives",
    ["starcraft-forge-warp-anchor"] = "starcraft-forge-warp-fade",
    ["starcraft-forge-warp-fade"] = "starcraft-forge",
    ["starcraft-stargate-warp-anchor"] = "starcraft-stargate-warp-fade",
    ["starcraft-stargate-warp-fade"] = "starcraft-stargate",
    ["starcraft-fleet-beacon-warp-anchor"] = "starcraft-fleet-beacon-warp-fade",
    ["starcraft-fleet-beacon-warp-fade"] = "starcraft-fleet-beacon",
    ["starcraft-tribunal-warp-anchor"] = "starcraft-tribunal-warp-fade",
    ["starcraft-tribunal-warp-fade"] = "starcraft-tribunal",
    ["starcraft-robotics-support-bay-warp-anchor"] = "starcraft-robotics-support-bay-warp-fade",
    ["starcraft-robotics-support-bay-warp-fade"] = "starcraft-robotics-support-bay",
    ["starcraft-shield-battery-warp-anchor"] = "starcraft-shield-battery-warp-fade",
    ["starcraft-shield-battery-warp-fade"] = "starcraft-shield-battery"
}

-- TODO: Move
local function sc_to_factorio_ticks(ticks)
    return math.floor(ticks * 42 / (1000 / 60))
end

local build_times = {
    ["starcraft-nexus-warp-anchor"] = sc_to_factorio_ticks(1800),
    ["starcraft-robotics-facility-warp-anchor"] = sc_to_factorio_ticks(1200),
    ["starcraft-pylon-warp-anchor"] = sc_to_factorio_ticks(450),
    ["starcraft-assimilator-warp-anchor"] = sc_to_factorio_ticks(600),
    ["starcraft-observatory-warp-anchor"] = sc_to_factorio_ticks(450),
    ["starcraft-gateway-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-cannon-warp-anchor"] = sc_to_factorio_ticks(750),
    ["starcraft-citadel-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-cyber-core-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-archives-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-forge-warp-anchor"] = sc_to_factorio_ticks(600),
    ["starcraft-stargate-warp-anchor"] = sc_to_factorio_ticks(1050),
    ["starcraft-fleet-beacon-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-tribunal-warp-anchor"] = sc_to_factorio_ticks(900),
    ["starcraft-robotics-support-bay-warp-anchor"] = sc_to_factorio_ticks(450),
    ["starcraft-shield-battery-warp-anchor"] = sc_to_factorio_ticks(450)
}

-- Timings:
-- State 0: warp anchor created - 30 ticks
-- State 1: warp anchor - See build_times
-- State 2: warp in and fade - 173 ticks

local WARP_ANCHOR_CREATED_DELAY = 29
local WARP_IN_DELAY = 138
local WARP_FLASH_DELAY = 9

local VARIATION_WARP_IN = 1
local VARIATION_WARP_REPEAT = 2
local VARIATION_WARP_FLASH = 3

local function add_next_update(entity, order_state, ticks)
    local data = Entity.get_data(entity) or {}
    data.order_state = order_state
    Entity.set_data(entity, data)

    update_tracker:add(entity, ticks)
end

-- TODO: Copy hp/shields
local function progress_replace_entity(entity)
    local result = entity.surface.create_entity{
        name = entity_progress_table[entity.name],
        position = entity.position,
        direction = entity.direction,
        force = entity.force,
        --fast_replace = true,
        --spill = false,
        create_build_effect_smoke = false,
        move_stuck_players = false
    }
    entity.destroy()
    return result
end

local function update_entity_progress(entity)
    if entity == nil or not entity.valid then return end
    local data = Entity.get_data(entity) or {}

    if data.order_state == 0 then
        entity.graphics_variation = VARIATION_WARP_REPEAT
        add_next_update(entity, 1, build_times[entity.name])
    elseif data.order_state == 1 then
        entity.graphics_variation = VARIATION_WARP_FLASH
        add_next_update(entity, 2, WARP_FLASH_DELAY)
    elseif data.order_state == 2 then
        entity = progress_replace_entity(entity)
        add_next_update(entity, 3, WARP_IN_DELAY)
        entity.surface.play_sound{
            path = "entity-build/" .. entity.name,
            position = entity.position
        }
    elseif data.order_state == 3 then
        progress_replace_entity(entity)
    end
end

function CUnitPBuild.update()
    local advances = update_tracker:pop_current_tick()
    if advances ~= nil then
        table.each(advances, update_entity_progress)
    end

    -- TODO ind. frame updates for hp/shields gaining from 1 to max
end

function CUnitPBuild.add_warp_anchor(entity)
    add_next_update(entity, 0, WARP_ANCHOR_CREATED_DELAY)
    entity.surface.play_sound{
        path = "entity-build/" .. entity.name,
        position = entity.position
    }
end

return CUnitPBuild
