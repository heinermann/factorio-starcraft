-- Extension of Factorio stdlib. Surface-specific information designated to a force.

local ForceSurface = {
    __class = 'ForceSurface',
    __index = require('__stdlib__/stdlib/core')
}
setmetatable(ForceSurface, ForceSurface)

local Is = require('__stdlib__/stdlib/utils/is')
local Game = require('__stdlib__/stdlib/game')

local LOOKUP_KEY = '_forcesurface_data'

function ForceSurface.get_data(surface, force)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)
    Is.Assert(surface, 'invalid surface')
    Is.Assert(force, 'invalid force')

    local glob = global[LOOKUP_KEY] or {}
    glob = glob[surface.index] or {}
    return glob[force.index]
end
ForceSurface.get = ForceSurface.get_data

function ForceSurface.set_data(surface, force, value)
    surface = Game.get_surface(surface)
    force = Game.get_force(force)
    Is.Assert(surface, 'invalid surface')
    Is.Assert(force, 'invalid force')

    if global[LOOKUP_KEY] == nil then
        global[LOOKUP_KEY] = {}
    end
    if global[LOOKUP_KEY][surface.index] == nil then
        global[LOOKUP_KEY][surface.index] = {}
    end

    global[LOOKUP_KEY][surface.index][force.index] = value
end
ForceSurface.set = ForceSurface.set_data

return ForceSurface
