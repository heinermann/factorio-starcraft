require("__starcraft__/external/class/class")

EntitySet = class()

function EntitySet:init(identifier)
    self.identifier = "entity_set_" .. identifier

    if storage[self.identifier] == nil then
        storage[self.identifier] = {}
    end
end

function EntitySet:insert(entity)
    storage[self.identifier][entity.unit_number] = entity
end

function EntitySet:remove(entity)
    storage[self.identifier][entity.unit_number] = nil
end

function EntitySet:remove_id(id)
    storage[self.identifier][id] = nil
end

function EntitySet:pairs()
    return pairs(storage[self.identifier])
end

function EntitySet:clear()
    storage[self.identifier] = {}
end

function EntitySet:table()
    return storage[self.identifier]
end

function EntitySet:contains(entity)
    return storage[self.identifier][entity.unit_number] ~= nil
end

function EntitySet:foreach(fn)
    for id, entity in self:pairs() do
        if entity.valid then
            fn(entity)
        else
            self:remove_id(id)
        end
    end
end