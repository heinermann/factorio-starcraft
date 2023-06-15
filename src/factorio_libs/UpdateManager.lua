require("__starcraft__/external/class/class")
local table = require('__stdlib__/stdlib/utils/table')

UpdateManager = class()

function UpdateManager:init(identifier)
    self.identifier = "update_mgr_" .. identifier

    if global[self.identifier] == nil then
        global[self.identifier] = {}
    end
end

function UpdateManager:add(item, ticks_from_current)
    local target_frame = game.tick + ticks_from_current

    if global[self.identifier][target_frame] == nil then
        global[self.identifier][target_frame] = {}
    end

    table.insert(global[self.identifier][target_frame], item)
end

function UpdateManager:pop_current_tick()
    local result = global[self.identifier][game.tick]
    global[self.identifier][game.tick] = nil
    return result
end

-- Pops the current tick and calls a function for each item to be updated.
function UpdateManager:update(fn)
    local advances = self:pop_current_tick()
    if advances ~= nil then
        table.each(advances, fn)
    end
end
