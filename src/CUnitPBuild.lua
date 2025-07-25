require("factorio_libs.UpdateManager")
require("factorio_libs.EntitySet")

local Entity = require('__starcraft__/external/stdlib/entity/entity')
local ShieldManager = require("ShieldManager")

local CUnitPBuild = {}
local update_tracker = UpdateManager:new("CUnitPBuild")
local tracking_protoss_constructions = EntitySet:new("CUnitPBuild")

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

local WARP_ANCHOR_CREATED_DELAY = 28
local FADE_IN_DELAY = 52
local FADE_OUT_DELAY = 120
local WARP_FLASH_DELAY = 5

local VARIATION_WARP_ANCHOR_INIT = 1
local VARIATION_WARP_ANCHOR_SHOWN = 2
local VARIATION_WARP_ANCHOR_HIDDEN = 3

local VARIATION_FADE_GFX_HIDDEN = 1
local VARIATION_FADE_GFX_SHOWN = 2

local STATE_ANCHOR_WARP_IN = 0
local STATE_ANCHOR_WAIT_BUILD = 1
local STATE_ANCHOR_WARP_FLASH = 2
local STATE_WARP_FADE_IN_TEXTURE = 3
local STATE_WARP_FADE_OUT = 4

-- hp / 10 = starting hp amount
-- shields / 10 = starting shield amount
local function get_hp_gain(hp, buildtime)
    hp = hp * 256
    if buildtime ~= 0 then
        local result = (hp - hp / 10 + buildtime - 1) / buildtime
        if result ~= 0 then
            return result / 256
        end
    end
    -- 1/256 of a hit point every 1 starcraft tick (2.52 Factorio ticks)
    return 1 / 256 / 2.52
end

local function get_shield_gain(shields, buildtime)
    --shields = shields / 256
    if shields ~= 0 then
        if buildtime ~= 0 then
            local result = (shields - shields / 10) / buildtime
            if result ~= 0 then
                return result
            end
        end
    end
    return 1 / 256 / 2.52
end

local function add_next_update(entity, order_state, ticks)
    local data = Entity.get_data(entity) or {}
    data.order_state = order_state
    Entity.set_data(entity, data)

    update_tracker:add(entity, ticks)
end

local function inherit_data(entity, src_data)
    local data = Entity.get_data(entity) or {}
    data.max_shields = src_data.max_shields
    data.shields = src_data.shields
    Entity.set_data(entity, data)
end

local function progress_replace_entity(entity)
    CUnitPBuild.destroy_warp_anchor(entity)

    local old_data = Entity.get_data(entity)
    local old_health = entity.health
    local result = entity.surface.create_entity{
        name = entity_progress_table[entity.name],
        position = entity.position,
        direction = entity.direction,
        force = entity.force,
        fast_replace = true,
        spill = false,
        create_build_effect_smoke = false,
        move_stuck_players = false
    }
    result.health = old_health
    inherit_data(result, old_data)
    return result
end

local function play_warpin_anim(entity)
    -- Thanks to Honktown
    local anim_speed = 1/2.5
    rendering.draw_animation{
        animation = entity.name,
        render_layer = "object",
        animation_speed = anim_speed,
        animation_offset = -((game.tick % (69 / anim_speed)) * anim_speed),
        target = entity,
        surface = entity.surface
    }
end

local function play_entity_sound(entity, sound)
    entity.surface.play_sound{
        path = sound,
        position = entity.position
    }
end

local order_state_fns = {
    [STATE_ANCHOR_WARP_IN] = function(entity)
        entity.graphics_variation = VARIATION_WARP_ANCHOR_SHOWN
        add_next_update(entity, STATE_ANCHOR_WAIT_BUILD, build_times[entity.name])
    end,

    [STATE_ANCHOR_WAIT_BUILD] = function(entity)
        entity.graphics_variation = VARIATION_WARP_ANCHOR_HIDDEN
        entity.surface.create_trivial_smoke{
            name = "starcraft-warp-anchor-flash",
            position = entity.position
        }
        add_next_update(entity, STATE_ANCHOR_WARP_FLASH, WARP_FLASH_DELAY)
    end,

    [STATE_ANCHOR_WARP_FLASH] = function(entity)
        entity = progress_replace_entity(entity)
        play_warpin_anim(entity)
        play_entity_sound(entity, "entity-build/" .. entity.name)
        add_next_update(entity, STATE_WARP_FADE_IN_TEXTURE, FADE_IN_DELAY)
    end,

    [STATE_WARP_FADE_IN_TEXTURE] = function(entity)
        entity.graphics_variation = VARIATION_FADE_GFX_SHOWN
        add_next_update(entity, STATE_WARP_FADE_OUT, FADE_OUT_DELAY)
    end,

    [STATE_WARP_FADE_OUT] = function(entity)
        progress_replace_entity(entity)
    end,
}

local function update_entity_progress(entity)
    if entity == nil or not entity.valid then return end
    local data = Entity.get_data(entity)

    order_state_fns[data.order_state](entity)
end

function CUnitPBuild.on_update()
    update_tracker:update(update_entity_progress)

    tracking_protoss_constructions:foreach(function(entity)
        local data = Entity.get_data(entity) or {}
        entity.health = math.min(entity.health + data.hp_gain, entity.max_health)
        data.shields = math.min(data.shields + data.shield_gain, data.max_shields)
        Entity.set_data(entity, data)
        ShieldManager.queue_update_shield_bar(entity)
    end)
end

function CUnitPBuild.add_warp_anchor(entity)
    add_next_update(entity, STATE_ANCHOR_WARP_IN, WARP_ANCHOR_CREATED_DELAY)
    play_entity_sound(entity, "entity-build/" .. entity.name)

    local data = Entity.get_data(entity) or {}
    local build_time = build_times[entity.name]

    entity.health = entity.max_health / 10
    data.shields = data.max_shields / 10

    data.hp_gain = get_hp_gain(entity.max_health, build_time)
    data.shield_gain = get_shield_gain(data.max_shields, build_time)
    Entity.set_data(entity, data)

    tracking_protoss_constructions:insert(entity)
end

function CUnitPBuild.destroy_warp_anchor(entity)
    tracking_protoss_constructions:remove(entity)
end

return CUnitPBuild
