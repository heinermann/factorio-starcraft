require("__starcraft__/class/class")

UpdateManager = class()

function UpdateManager:init(identifier)
    self.identifier = "update_mgr_" .. identifier

    if global[self.identifier] == nil then
        global[self.identifier] = {}
    end

    self.data = global[self.identifier]
end

function UpdateManager:add(item, target_frame)
    if target_frame == nil or target_frame <= game.tick then
        target_frame = game.tick + 1
    end

    if self.data[target_frame] == nil then
        self.data[target_frame] = {}
    end

    table.insert(self.data[target_frame], item)
end

function UpdateManager:pop_current_tick()
    local result = self.data[game.tick]
    self.data[game.tick] = nil
    return result
end
