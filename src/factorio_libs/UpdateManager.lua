require("__starcraft__/external/class/class")
local table = require("__starcraft__/external/stdlib/utils/table")

UpdateManager = class()

function UpdateManager:init(identifier)
    self.identifier = "update_mgr_" .. identifier

    if storage[self.identifier] == nil then
        storage[self.identifier] = {}
    end
end

function UpdateManager:add(item, ticks_from_current)
    local target_frame = game.tick + ticks_from_current

    if storage[self.identifier][target_frame] == nil then
        storage[self.identifier][target_frame] = {}
    end

    table.insert(storage[self.identifier][target_frame], item)
end

function UpdateManager:pop_current_tick()
    local result = storage[self.identifier][game.tick]
    storage[self.identifier][game.tick] = nil
    return result
end

-- Pops the current tick and calls a function for each item to be updated.
function UpdateManager:update(fn)
    local advances = self:pop_current_tick()
    if advances ~= nil then
        table.each(advances, fn)
    end
end
