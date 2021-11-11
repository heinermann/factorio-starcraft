require("__starcraft__/external/class/class")

EntitySet = class()

function EntitySet:init(identifier)
    self.identifier = "entity_set_" .. identifier

    if global[self.identifier] == nil then
        global[self.identifier] = {}
    end
end

function EntitySet:insert(entity)
    global[self.identifier][entity.unit_number] = entity
end

function EntitySet:remove(entity)
    global[self.identifier][entity.unit_number] = nil
end

function EntitySet:pairs()
    return pairs(global[self.identifier])
end

function EntitySet:table()
    return global[self.identifier]
end

function EntitySet:contains(entity)
    return global[self.identifier][entity.unit_number] ~= nil
end
