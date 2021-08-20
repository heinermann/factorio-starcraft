-- Extension of Factorio stdlib. Tile-specific information in alternative format.

local Tile = {
    __class = 'Tile',
    __index = require('__stdlib__/stdlib/core')
}
setmetatable(Tile, Tile)

local Is = require('__stdlib__/stdlib/utils/is')
local Game = require('__stdlib__/stdlib/game')
local Position = require('__stdlib__/stdlib/area/position')

local LOOKUP_KEY = '_tile_data'

function Tile.get_data(surface, key, tile_pos)
    surface = Game.get_surface(surface)
    Is.Assert(surface, 'invalid surface')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    local glob = global[LOOKUP_KEY] or {}
    glob = glob[surface.index] or {}
    glob = glob[key] or {}
    return glob[pos_key]
end
Tile.get = Tile.get_data

function Tile.set_data(surface, key, tile_pos, value)
    surface = Game.get_surface(surface)
    Is.Assert(surface, 'invalid surface')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    if global[LOOKUP_KEY] == nil then
        global[LOOKUP_KEY] = {}
    end
    if global[LOOKUP_KEY][surface.index] == nil then
        global[LOOKUP_KEY][surface.index] = {}
    end
    if global[LOOKUP_KEY][surface.index][key] == nil then
        global[LOOKUP_KEY][surface.index][key] = {}
    end

    global[LOOKUP_KEY][surface.index][key][pos_key] = value
end
Tile.set = Tile.set_data

return Tile
