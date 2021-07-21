-- Extension of Factorio stdlib. Tile-specific information designated to a force.

local ForceTile = {
    __class = 'ForceTile',
    __index = require('__stdlib__/stdlib/core')
}
setmetatable(ForceTile, ForceTile)

local Is = require('__stdlib__/stdlib/utils/is')
local Game = require('__stdlib__/stdlib/game')
local Position = require('__stdlib__/stdlib/area/position')

local LOOKUP_KEY = '_forcetile_data'

function ForceTile.get_data(surface, force, key, tile_pos)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)
    Is.Assert(surface, 'invalid surface')
    Is.Assert(force, 'invalid force')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    local glob = global[LOOKUP_KEY] or {}
    glob = glob[surface.index] or {}
    glob = glob[force.index] or {}
    glob = glob[key] or {}
    return glob[pos_key]
end
ForceTile.get = ForceTile.get_data

function ForceTile.set_data(surface, force, key, tile_pos, value)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)
    Is.Assert(surface, 'invalid surface')
    Is.Assert(force, 'invalid force')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    if global[LOOKUP_KEY] == nil then
        global[LOOKUP_KEY] = {}
    end
    if global[LOOKUP_KEY][surface.index] == nil then
        global[LOOKUP_KEY][surface.index] = {}
    end
    if global[LOOKUP_KEY][surface.index][force.index] == nil then
        global[LOOKUP_KEY][surface.index][force.index] = {}
    end
    if global[LOOKUP_KEY][surface.index][force.index][key] == nil then
        global[LOOKUP_KEY][surface.index][force.index][key] = {}
    end

    global[LOOKUP_KEY][surface.index][force.index][key][pos_key] = value
end
ForceTile.set = ForceTile.set_data

return ForceTile
