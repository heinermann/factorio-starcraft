require("factorio_libs.UpdateManager")
local table = require('__stdlib__/stdlib/utils/table')
local Entity = require('__stdlib__/stdlib/entity/entity')
local CUnitProtoss = require("CUnitProtoss")

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

local WARP_ANCHOR_CREATED_DELAY = 28
local WARP_IN_DELAY = 170
local WARP_FLASH_DELAY = 5

local VARIATION_WARP_ANCHOR_INIT = 1
local VARIATION_WARP_ANCHOR_SHOWN = 2
local VARIATION_WARP_ANCHOR_HIDDEN = 3

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
    global.tracking_protoss_constructions[entity.unit_number] = nil
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

local function update_entity_progress(entity)
    if entity == nil or not entity.valid then return end
    local data = Entity.get_data(entity) or {}

    if data.order_state == 0 then
        entity.graphics_variation = VARIATION_WARP_ANCHOR_SHOWN
        add_next_update(entity, 1, build_times[entity.name])
    elseif data.order_state == 1 then
        entity.graphics_variation = VARIATION_WARP_ANCHOR_HIDDEN
        entity.surface.create_trivial_smoke{
            name = "starcraft-warp-anchor-flash",
            position = entity.position
        }
        add_next_update(entity, 2, WARP_FLASH_DELAY)
    elseif data.order_state == 2 then
        entity = progress_replace_entity(entity)
        play_warpin_anim(entity)
        add_next_update(entity, 3, WARP_IN_DELAY)
        entity.surface.play_sound{
            path = "entity-build/" .. entity.name,
            position = entity.position
        }
    elseif data.order_state == 3 then
        progress_replace_entity(entity)
    end
end

function CUnitPBuild.on_update()
    local advances = update_tracker:pop_current_tick()
    if advances ~= nil then
        table.each(advances, update_entity_progress)
    end

    for _, entity in pairs(global.tracking_protoss_constructions) do
        if entity.valid then
            local data = Entity.get_data(entity) or {}
            entity.health = math.min(entity.health + data.hp_gain, entity.prototype.max_health)
            data.shields = math.min(data.shields + data.shield_gain, data.max_shields)
            Entity.set_data(entity, data)
            CUnitProtoss.update_shield_bars(entity) -- TODO: Queue up
        end
    end
end

function CUnitPBuild.add_warp_anchor(entity)
    add_next_update(entity, 0, WARP_ANCHOR_CREATED_DELAY)
    entity.surface.play_sound{
        path = "entity-build/" .. entity.name,
        position = entity.position
    }

    local data = Entity.get_data(entity) or {}

    local build_time = build_times[entity.name]

    entity.health = entity.prototype.max_health / 10
    data.shields = data.max_shields / 10

    data.hp_gain = get_hp_gain(entity.prototype.max_health, build_time)
    data.shield_gain = get_shield_gain(data.max_shields, build_time)

    Entity.set_data(entity, data)

    global.tracking_protoss_constructions[entity.unit_number] = entity
end

function CUnitPBuild.destroy_warp_anchor(entity)
    global.tracking_protoss_constructions[entity.unit_number] = nil
end

function CUnitPBuild.on_init()
    global.tracking_protoss_constructions = {}
end

return CUnitPBuild
