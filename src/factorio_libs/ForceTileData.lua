require("__starcraft__/external/class/class")

ForceTileData = class()

local Game = require('__starcraft__/external/stdlib/game')
local Position = require('__starcraft__/external/stdlib/area/position')

local GLOBAL_KEY = '_forcetiledata'

function ForceTileData:init(lookup_key)
    self.lookup_key = lookup_key

    if storage[GLOBAL_KEY] == nil then
        storage[GLOBAL_KEY] = {}
    end
end

function ForceTileData:get_data(surface, force, tile_pos)
    local pos_key = Position.to_key(Position.floor(tile_pos))

    local glob = storage[GLOBAL_KEY]
    glob = glob[surface.index] or {}
    glob = glob[force.index] or {}
    glob = glob[self.lookup_key] or {}
    return glob[pos_key]
end

function ForceTileData:set_data(surface, force, tile_pos, data)
    local pos_key = Position.to_key(Position.floor(tile_pos))

    if storage[GLOBAL_KEY][surface.index] == nil then
        storage[GLOBAL_KEY][surface.index] = {}
    end
    if storage[GLOBAL_KEY][surface.index][force.index] == nil then
        storage[GLOBAL_KEY][surface.index][force.index] = {}
    end
    if storage[GLOBAL_KEY][surface.index][force.index][self.lookup_key] == nil then
        storage[GLOBAL_KEY][surface.index][force.index][self.lookup_key] = {}
    end

    storage[GLOBAL_KEY][surface.index][force.index][self.lookup_key][pos_key] = data
end

ForceTileData.get = ForceTileData.get_data
ForceTileData.set = ForceTileData.set_data
