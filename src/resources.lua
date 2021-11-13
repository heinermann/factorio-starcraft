require("factorio_libs.UpdateManager")
local Entity = require('__stdlib__/stdlib/entity/entity')
local table = require('__stdlib__/stdlib/utils/table')

local Resources = {}
local vespene_geyser_tracker = UpdateManager:new("VespeneGeysers")

local gas_overlay_data = {
    ["starcraft-extractor"] = {  -- Extractor gas overlays
        {
            {16, -45},
            {127, 127},
            {127, 127},
            {127, 127},
            {127, 127},
        }
    },
    ["starcraft-assimilator"] = { -- Assimilator gas overlays
        {
            {26, -58},
            {127, 127},
            {39, -18},
            {-42, -51},
            {127, 127},
        }
    },
    ["starcraft-refinery"] = { -- Refinery gas overlays
        {
            {7, -53},
            {127, 127},
            {127, 127},
            {127, 127},
            {127, 127},
        }, {
            {7, -16},
            {-41, -18},
            {41, -3},
            {127, 127},
            {127, 127},
        }, {
            {7, -16},
            {-41, -18},
            {2, 3},
            {127, 127},
            {127, 127},
        }, {
            {7, -36},
            {-41, -18},
            {2, 3},
            {127, 127},
            {127, 127},
        }, {
            {7, -45},
            {-41, -18},
            {2, 3},
            {127, 127},
            {127, 127},
        }
    },
    ["starcraft-vespene-geyser"] = { -- vespene geyser overlays
        {
            {11, -19},
            {-40, -13},
            {34, 2},
            {127, 127},
            {127, 127}
        }
    }
}

local gas_overlay_anim_indices = {
    ["starcraft-extractor"] = { 1 },
    ["starcraft-assimilator"] = { 1, 4, 3, 4, 1, 3 },
    ["starcraft-refinery"] = { 1, 3, 2, 3, 1, 2, 3 },
    ["starcraft-vespene-geyser"] = { 1, 3, 2, 3, 1, 2, 3 }
}

local function get_gas_overlays(entity, state)
    return gas_overlay_data[entity.name][state or 1]
end

-- Convert a BW pixel to Factorio tile
local function to_tiles(value)
    return value / 16.0
end

local gasoverlays = {
    "starcraft-vespene-smoke-1",
    "starcraft-vespene-smoke-2",
    "starcraft-vespene-smoke-3",
    "starcraft-vespene-smoke-4",
    "starcraft-vespene-smoke-5"
}
local function creategasoverlays(entity, num)
    -- TODO: refinery state
    local overlay_positions = get_gas_overlays(entity)

    local entity_pos = entity.position
    local target_position = {
        entity_pos.x + to_tiles(overlay_positions[num][1]),
        entity_pos.y + to_tiles(overlay_positions[num][2]),
    }

    if entity.type == "resource" and entity.amount == 0 then
        entity.surface.create_trivial_smoke{
            name = "starcraft-vespene-smoke-depleted",
            position = target_position
        }
    else
        entity.surface.create_trivial_smoke{
            name = gasoverlays[num],
            position = target_position
        }
    end
end

-- Convert BW frames to Factorio ticks
local function to_ticks(value)
    --- BW 42ms / frame, Factorio 1000/60 ms per frame
    return math.ceil((value * 42) * 0.06)
end

-- Script variations
local wait_fns = {
    ["starcraft-extractor"] = function(state)
        return to_ticks(24)
    end,
    ["starcraft-refinery-incomplete"] = function(state)
        return to_ticks(math.random(5, 100) + 20)
    end,
    ["starcraft-refinery"] = function(state)
        local result = to_ticks(math.random(5, 50))
        if state == 1 then
            return result + to_ticks(5)
        end
        return result
    end,
    ["starcraft-assimilator"] = function(state)
        local result = to_ticks(math.random(5, 50))
        if state == 1 then
            return result + to_ticks(math.random(5, 50))
        end
        return result
    end,
    ["starcraft-vespene-geyser"] = function(state)
        return to_ticks(math.random(5, 50))
    end
}

local initial_wait_fns = {
    ["starcraft-extractor"] = function()
        return to_ticks(math.random(1, 5) + 6)
    end,
    ["starcraft-refinery"] = function()
        return to_ticks(math.random(5, 50) + 5)
    end,
    ["starcraft-assimilator"] = function()
        return to_ticks(math.random(5, 50))
    end,
    ["starcraft-vespene-geyser"] = function()
        return to_ticks(15)
    end,
}

local function advance_gas_anim(entity)
    if not entity.valid then return end
    local data = Entity.get_data(entity)
    local overlay_indices = gas_overlay_anim_indices[entity.name]

    creategasoverlays(entity, overlay_indices[data.gas_state])

    data.gas_state = (data.gas_state % #overlay_indices) + 1
    Entity.set_data(entity, data)

    local wait_time = wait_fns[entity.name](data.gas_state)
    vespene_geyser_tracker:add(entity, wait_time)
end

local function init_gas_overlays(entity)
    local wait_time = 1
    local wait_fn = initial_wait_fns[entity.name]
    if wait_fn ~= nil then
        wait_time = wait_fn()
    end
    vespene_geyser_tracker:add(entity, wait_time)
end

local function setup_vespene_geyser(entity)
    local gas_box = entity.bounding_box
    local minerals_filter = {
        name = "starcraft-mineral-field",
        type = "resource",
        force = "neutral"
    }

    -- Define bounds to search from this geyser
    local left_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.left_top.x, gas_box.right_bottom.y + 32}}
    local top_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.left_top.y}}
    local right_bounds = {{gas_box.right_bottom.x, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
    local bottom_bounds = {{gas_box.left_top.x - 32, gas_box.right_bottom.y}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
    local all_bounds = {left_bounds, top_bounds, right_bounds, bottom_bounds}

    -- Find the side of the geyser with the least minerals
    local best_count = math.huge
    local best_bounds = left_bounds
    for _, area in pairs(all_bounds) do
        minerals_filter.area = area
        local count = entity.surface.count_entities_filtered(minerals_filter)
        if count < best_count then
        best_count = count
        best_bounds = area
        end
    end

    -- remove minerals from the side of the geyser that has the least
    minerals_filter.area = best_bounds
    for _, entity in pairs(entity.surface.find_entities_filtered(minerals_filter)) do
        entity.deplete()
    end
end

function Resources.setup_resource(entity)
    if not entity.valid then return end

    entity.surface.destroy_decoratives{area = entity.selection_box}

    if entity.name == "starcraft-vespene-geyser" then
        setup_vespene_geyser(entity)
    end
end

function Resources.register_gas_building(entity)
    local data = Entity.get_data(entity) or {}
    data.gas_state = 1
    Entity.set_data(entity, data)

    init_gas_overlays(entity)
end

function Resources.on_update()
    local advances = vespene_geyser_tracker:pop_current_tick()
    if advances ~= nil then
        table.each(advances, advance_gas_anim)
    end
end

return Resources
