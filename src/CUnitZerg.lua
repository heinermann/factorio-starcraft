local Entity = require('__stdlib__/stdlib/entity/entity')
local Surface = require('__stdlib__/stdlib/area/surface')
local table = require('__stdlib__/stdlib/utils/table')

local CUnitZerg = {
    creep_entities = {}
}

-- TODO: Move this all to creep.lua

local function has_collision_nearby(x, y, surface, mask)
    return surface.count_tiles_filtered{
        area = {{x - 1, y - 1}, {x + 2, y + 2}},
        limit = 1,
        collision_mask = mask
    } ~= 0
end

local function tile_can_have_creep(x, y, surface)
    return surface.get_hidden_tile({x, y}) == nil and
        not has_collision_nearby(x, y, surface, "water-tile")
end

local function is_creep(x, y, surface)
    local tile = surface.get_tile(x, y)
    return tile.name == "zerg-creep"
end

-- TODO Find only structures...
local function tile_occupied(x, y, surface)
    return surface.count_entities_filtered{
        area = {{x, y}, {x + 1, y + 1}},
        collision_mask = "object-layer",
        limit = 1
    } ~= 0
end

local function get_max_creep_bounds(x, y)
    return {
        x - 20,
        y - 12,
        x + 20,
        y + 12
    }
end

-- TODO: optimize this by assigning neighbor values when creep is created instead to get rid of re-counting in a loop which is expensive
local function count_neighboring_creep(x, y, surface)
    return surface.count_tiles_filtered{
        area = {{x - 1, y - 1}, {x + 2, y + 2}},
        name = "zerg-creep"
    }
end

-- TODO: optimize, queue tile changes and call set_tiles later
local function set_tile_creep(position, surface)
    surface.set_hidden_tile(position, surface.get_tile(position.x, position.y).name)
    surface.set_tiles(
        {
            { position = position, name = "zerg-creep" }
        },
        true,   -- correct_tiles
        false,  -- remove_colliding_entities
        true,   -- remove_colliding_decoratives
        true    -- raise_event
    )
end

-- TODO: optimize/rework algorithm (this is a copy of Starcraft's algorithm)
local function spread_creep(x, y, surface)
    local best_spread_neighbours = 0
    local spread_candidates = {}

    -- Find spread candidates
    local bounds = get_max_creep_bounds(x, y)
    for iy = bounds[2], bounds[4] do
        local y_px = (iy - y) * 16 + 16
        for ix = bounds[1], bounds[3] do
            if not is_creep(ix, iy, surface) and tile_can_have_creep(ix, iy, surface) and not tile_occupied(ix, iy, surface) then
                local x_px = (ix - x) * 16 + 16
                local cur_neighbors = count_neighboring_creep(ix, iy, surface)

                if 1 <= cur_neighbors and cur_neighbors <= 8 and (100 * x_px * x_px + 256 * y_px * y_px) <= 10240000 and cur_neighbors >= best_spread_neighbours then
                    if cur_neighbors > best_spread_neighbours then
                        spread_candidates = {}
                        best_spread_neighbours = cur_neighbors
                    end

                    table.insert(spread_candidates, {x = ix, y = iy})
                end
            end
        end
    end

    if #spread_candidates == 0 then
        return
    end

    local spread_target = spread_candidates[math.random(1, #spread_candidates)]
    -- TODO: figure out wtf Starcraft is doing here
    set_tile_creep(spread_target, surface)
end

local function register_creep_provider(entity)
    CUnitZerg.creep_entities[entity] = true
end

function CUnitZerg.on_creep_provider_created(entity)
    local data = Entity.get_data(entity) or {}

    -- 15 starcraft ticks, but there are 4 factorio tiles in 1 starcraft tile
    data.creep_timer = 10

    Entity.set_data(entity, data)
    register_creep_provider(entity)
end

function CUnitZerg.on_creep_provider_destroyed(entity)
    CUnitZerg.creep_entities[entity] = nil
end

function CUnitZerg.on_update()
    for entity, _ in pairs(CUnitZerg.creep_entities) do
        local data = Entity.get_data(entity) or {}
        if data.creep_timer > 0 then
            data.creep_timer = data.creep_timer - 1
        else
            data.creep_timer = 10
            spread_creep(entity.position.x, entity.position.y, entity.surface)
        end
        Entity.set_data(entity, data)
    end
end

local creep_providers = {
    "starcraft-hatchery",
    "starcraft-lair",
    "starcraft-hive",
    "starcraft-creep-colony",
    "starcraft-sunken-colony",
    "starcraft-spore-colony",
}

function CUnitZerg.on_load()
	local entities = Surface.find_all_entities{name = creep_providers}
	table.each(entities, register_creep_provider)
end

return CUnitZerg
