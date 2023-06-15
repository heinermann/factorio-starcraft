require("factorio_libs.UpdateManager")
require("factorio_libs.EntitySet")

local Entity = require('__stdlib__/stdlib/entity/entity')

local HoverManager = {}
local hovering_entities = EntitySet:new("AirUnitHovering")
local update_tracker = UpdateManager:new("AirUnitHovering")

-- Units that hover are:
-- Scourge, Overlord,
-- Battlecruiser (only after moving, but not after attacking or spawning in), Dropship, Wraith, Valkyrie,
-- Arbiter, Carrier, Interceptor, Shuttle, Scout, Observer, Corsair
--
-- All hovering uses the same anims as the Overlord, Scourge has a special hovering anim
-- There is also a special case in which cloaked units will not hover. This is why observers never hover despite it being coded,
-- because it is permanently cloaked.

------------------------------------------------------------------------------------------------------------------------------------------
-- IScript and positioning
------------------------------------------------------------------------------------------------------------------------------------------
-- Convert BW frames to Factorio ticks
local function to_ticks(value)
    --- BW 42ms / frame, Factorio 1000/60 ms per frame
    return math.ceil((value * 42) * 0.06)
end

function to_tiles(value)
    return value / 32 * 2
end

-- setvertpos(1) moves the unit's graphic down 1 pixel. We should move the shadow to the left to match.
local function setvertpos(entity, y_offset)
    y_offset = to_tiles(y_offset)

    local data = Entity.get_data(entity)

    if data.main_graphics then
        for _, graphic in ipairs(data.main_graphics) do
            rendering.set_target(graphic, entity, {0, y_offset})
        end
    end
    if data.shadow_graphic then
        -- Note: The main shadow offset should be determined in data, makes this easier
        rendering.set_target(data.shadow_graphic, entity, {-y_offset, 0})
    end
end
------------------------------------------------------------------------------------------------------------------------------------------
-- Hover updates
------------------------------------------------------------------------------------------------------------------------------------------

local function add_next_update(entity, index, ticks)
    local data = Entity.get_data(entity) or {}
    data.flyer_hover_index = index
    Entity.set_data(entity, data)

    update_tracker:add(entity, ticks)
end

-- TODO: Scourge will desync with its animation
local scourge_update_fns = {
    [1] = function(entity)
        setvertpos(entity, 0)
        add_next_update(entity, 2, to_ticks(6))
    end,
    [2] = function(entity)
        setvertpos(entity, 1)
        add_next_update(entity, 3, to_ticks(3))
    end,
    [3] = function(entity)
        setvertpos(entity, 2)
        add_next_update(entity, 4, to_ticks(3))
    end,
    [4] = function(entity)
        setvertpos(entity, 1)
        add_next_update(entity, 1, to_ticks(3))
    end
}

local hover_update_fns = {
    [1] = function(entity)
        setvertpos(entity, 1)
        add_next_update(entity, 2, to_ticks(math.random(8, 10)))
    end,
    [2] = function(entity)
        setvertpos(entity, 2)
        add_next_update(entity, 3, to_ticks(math.random(8, 10)))
    end,
    [3] = function(entity)
        setvertpos(entity, 1)
        add_next_update(entity, 4, to_ticks(math.random(8, 10)))
    end,
    [4] = function(entity)
        setvertpos(entity, 0)
        add_next_update(entity, 1, to_ticks(math.random(8, 10)))
    end
}

local function hover_update(entity)
    if entity == nil or not entity.valid or not hovering_entities:contains(entity) then return end

    local data = Entity.get_data(entity)
    if entity.name == 'starcraft-scourge' then
        scourge_update_fns[data.flyer_hover_index](entity)
    else
        hover_update_fns[data.flyer_hover_index](entity)
    end
end

------------------------------------------------------------------------------------------------------------------------------------------
-- Properties
------------------------------------------------------------------------------------------------------------------------------------------
local valid_hovering_entities = {
    ['starcraft-scourge'] = true,
    ['starcraft-overlord'] = true,
    ['starcraft-battlecruiser'] = true,
    ['starcraft-dropship'] = true,
    ['starcraft-wraith'] = true,
    ['starcraft-valkyrie'] = true,
    ['starcraft-arbiter'] = true,
    ['starcraft-carrier'] = true,
    ['starcraft-interceptor'] = true,
    ['starcraft-shuttle'] = true,
    ['starcraft-scout'] = true,
    ['starcraft-observer'] = true,
    ['starcraft-corsair'] = true
}

------------------------------------------------------------------------------------------------------------------------------------------
-- Hover management
------------------------------------------------------------------------------------------------------------------------------------------

function HoverManager.on_update()
    update_tracker:update(hover_update)
end

function HoverManager.register_for_hovering(entity)
    if not valid_hovering_entities[entity.name] then return end
    hovering_entities:insert(entity)

    if entity.name == "starcraft-scourge" then
        scourge_update_fns[1](entity)
    else
        hover_update_fns[1](entity)
    end
end

function HoverManager.unregister_for_hovering(entity)
    if not valid_hovering_entities[entity.name] then return end
    hovering_entities:remove(entity)
    setvertpos(entity, 0)
end


return HoverManager
