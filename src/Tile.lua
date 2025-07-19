-- Extension of Factorio stdlib. Tile-specific information in alternative format.

local Tile = {
    __class = 'Tile',
    __index = require('__starcraft__/external/stdlib/core')
}
setmetatable(Tile, Tile)

local Is = require('__starcraft__/external/stdlib/utils/is')
local Position = require('__starcraft__/external/stdlib/area/position')

local LOOKUP_KEY = '_tile_data'

function Tile.get_data(surface, key, tile_pos)
    Is.Assert(surface, 'invalid surface')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    local glob = storage[LOOKUP_KEY] or {}
    glob = glob[surface.index] or {}
    glob = glob[key] or {}
    return glob[pos_key]
end
Tile.get = Tile.get_data

function Tile.set_data(surface, key, tile_pos, value)
    Is.Assert(surface, 'invalid surface')

    local pos_key = Position.to_key(Position.floor(tile_pos))

    if storage[LOOKUP_KEY] == nil then
        storage[LOOKUP_KEY] = {}
    end
    if storage[LOOKUP_KEY][surface.index] == nil then
        storage[LOOKUP_KEY][surface.index] = {}
    end
    if storage[LOOKUP_KEY][surface.index][key] == nil then
        storage[LOOKUP_KEY][surface.index][key] = {}
    end

    storage[LOOKUP_KEY][surface.index][key][pos_key] = value
end
Tile.set = Tile.set_data

return Tile
