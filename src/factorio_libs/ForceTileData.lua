require("__starcraft__/external/class/class")

ForceTileData = class()

local Game = require('__stdlib__/stdlib/game')
local Position = require('__stdlib__/stdlib/area/position')

local GLOBAL_KEY = '_forcetiledata'

function ForceTileData:init(lookup_key)
    self.lookup_key = lookup_key

    if global[GLOBAL_KEY] == nil then
        global[GLOBAL_KEY] = {}
    end
end

function ForceTileData:get_data(surface, force, tile_pos)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)

    local pos_key = Position.to_key(Position.floor(tile_pos))

    local glob = global[GLOBAL_KEY]
    glob = glob[surface.index] or {}
    glob = glob[force.index] or {}
    glob = glob[self.lookup_key] or {}
    return glob[pos_key]
end

function ForceTileData:set_data(surface, force, tile_pos, data)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)

    local pos_key = Position.to_key(Position.floor(tile_pos))

    if global[GLOBAL_KEY][surface.index] == nil then
        global[GLOBAL_KEY][surface.index] = {}
    end
    if global[GLOBAL_KEY][surface.index][force.index] == nil then
        global[GLOBAL_KEY][surface.index][force.index] = {}
    end
    if global[GLOBAL_KEY][surface.index][force.index][self.lookup_key] == nil then
        global[GLOBAL_KEY][surface.index][force.index][self.lookup_key] = {}
    end

    global[GLOBAL_KEY][surface.index][force.index][self.lookup_key][pos_key] = data
end

ForceTileData.get = ForceTileData.get_data
ForceTileData.set = ForceTileData.set_data
