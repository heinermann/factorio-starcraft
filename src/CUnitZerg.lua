local Entity = require('__stdlib__/stdlib/entity/entity')
local Surface = require('__stdlib__/stdlib/area/surface')
local table = require('__stdlib__/stdlib/utils/table')
local Area = require('__stdlib__/stdlib/area/area')
local Position = require('__stdlib__/stdlib/area/position')

local CUnitZerg = {
    creep_entities = {}
}

-- TODO: Move this all to creep.lua ?

local function has_collision_nearby(pos, surface, mask)
    return surface.count_tiles_filtered{
        area = Area.expand(Position.to_tile_area(pos), 1),
        limit = 1,
        collision_mask = mask
    } ~= 0
end

local function can_spread_creep_to(pos, surface)
    local tile = surface.get_tile(pos)
    return tile.name ~= "zerg-creep" and tile.hidden_tile == nil and not has_collision_nearby(pos, surface, "water-tile")
end

-- TODO Find only structures...
local function tile_occupied(pos, surface)
    -- TODO: Look into `find_non_colliding_position_in_box`
    return surface.count_entities_filtered{
        area = Position.to_tile_area(pos),
        collision_mask = "object-layer",
        limit = 1
    } ~= 0
end

local function get_max_creep_bounds(pos)
    return {
        left_top = {
            x = pos.x - 20,
            y = pos.y - 12
        },
        right_bottom = {
            x = pos.x + 20,
            y = pos.y + 12
        }
    }
end

-- TODO: optimize this by assigning neighbor values when creep is created instead to get rid of re-counting in a loop which is expensive
local function count_neighboring_creep(pos, surface)
    return surface.count_tiles_filtered{
        area = Area.expand(Position.to_tile_area(pos), 1),
        name = "zerg-creep"
    }
end

-- TODO: optimize, queue tile changes and call set_tiles later
local function set_tile_creep(position, surface)
    surface.set_hidden_tile(position, surface.get_tile(position).name)
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

-- TODO: optimize/rework algorithm (this is a copy of Starcraft's algorithm, and is extremely taxing on Factorio)
local function spread_creep(pos, surface)
    local best_spread_neighbours = 0
    local spread_candidates = {}

    -- Find spread candidates
    local bounds = get_max_creep_bounds(pos)
    for ipos in Area.iterate(bounds, true) do
        if can_spread_creep_to(ipos, surface) and not tile_occupied(ipos, surface) then
            local check_x = ipos.x - pos.x + 0.5
            local check_y = ipos.y - pos.y + 0.5

            -- Is point within ellipse (converted from pixels to tiles, deviating to achieve similar outcome w/ Factorio's different scale)
            -- (check_x * check_x) / (20.5 * 20.5) + (check_y * check_y) / (13 * 13) <= 1
            if check_x * check_x * 169 + check_y * check_y * 420.25 <= 71022.25 then
                local cur_neighbors = count_neighboring_creep(ipos, surface)

                if 1 <= cur_neighbors and cur_neighbors <= 8 and cur_neighbors >= best_spread_neighbours then
                    if cur_neighbors > best_spread_neighbours then
                        spread_candidates = {}
                        best_spread_neighbours = cur_neighbors
                    end

                    table.insert(spread_candidates, ipos)
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

local function make_creep_below_structure(entity)
    local bounds = Area.offset(entity.prototype.map_generator_bounding_box, entity.position)
    local surface = entity.surface

    local tiles_to_change = {}

    for pos in Area.iterate(bounds, true, true) do
        if can_spread_creep_to(pos, surface) then
            surface.set_hidden_tile(pos, surface.get_tile(pos).name)
            table.insert(tiles_to_change, { position = pos, name = "zerg-creep" })
        end
    end

    surface.set_tiles(tiles_to_change,
        true,   -- correct_tiles
        false,  -- remove_colliding_entities
        true,   -- remove_colliding_decoratives
        true    -- raise_event
    )
end

local function register_creep_provider(entity)
    CUnitZerg.creep_entities[entity] = true
end

function CUnitZerg.on_creep_provider_created(entity)
    make_creep_below_structure(entity)

    local data = Entity.get_data(entity) or {}

    -- 15 starcraft ticks, but there are 4 factorio tiles in 1 starcraft tile
    data.creep_timer = 10

    Entity.set_data(entity, data)
    register_creep_provider(entity)
end

function CUnitZerg.on_creep_provider_destroyed(entity)
    CUnitZerg.creep_entities[entity] = nil
end

function CUnitZerg.on_creep_bldg_created(entity)
    make_creep_below_structure(entity)
end

function CUnitZerg.on_creep_bldg_destroyed(entity)
end

function CUnitZerg.on_update()
    for entity, _ in pairs(CUnitZerg.creep_entities) do
        local data = Entity.get_data(entity) or {}
        if data.creep_timer > 0 then
            data.creep_timer = data.creep_timer - 1
        else
            data.creep_timer = 10
            spread_creep(entity.position, entity.surface)
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
