require("__starcraft__/external/class/class")

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
