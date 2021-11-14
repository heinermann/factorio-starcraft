require("__starcraft__/external/class/class")
require("EntitySet")

StaggerUpdateManager = class()

function StaggerUpdateManager:init(identifier, step)
    self.identifier = "update_mgr_" .. identifier
    self.step = step or 2

    self.data = {}
    for i = 0, step - 1 do
        self.data[i] = EntitySet:new("_StaggerMgr_" .. tostring(i) .. "_" .. identifier)
    end
end

function StaggerUpdateManager:add(entity)
    local stagger_index = game.tick % self.step
    self.data[stagger_index]:insert(entity)
end

function StaggerUpdateManager:remove(entity)
    for i = 0, step - 1 do
        self.data[i]:remove(entity)
    end
end

function StaggerUpdateManager:pairs()
    local stagger_index = game.tick % self.step
    return self.data[stagger_index]:pairs()
end

function StaggerUpdateManager:foreach(fn)
    local stagger_index = game.tick % self.step
    self.data[stagger_index]:foreach(fn)
end
