local UpdateManager = {}
UpdateManager.__index = UpdateManager

function UpdateManager:create(identifier)
    local manager = {}
    setmetatable(manager, UpdateManager)

    manager.identifier = "update_mgr_" .. identifier

    if global[manager.identifier] == nil then
        global[manager.identifier] = {}
    end

    manager.data = global[manager.identifier]

    return manager
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

function UpdateManager:get_current()
    local result = self.data[game.tick]
    self.data[game.tick] = nil
    return result
end

return UpdateManager
