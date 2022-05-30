require("__starcraft__/external/class/class")
require("Orders")

local Entity = require('__stdlib__/stdlib/entity/entity')

AirUnit = class()

function CUnit:init(entity)
    self.entity = entity
    self:restoreData()

end

function CThingy:createInit()
end

function CThingy:restoreData()
    self.data = Entity.get_data(self.entity) or {}
end

function CThingy:writeData()
    Entity.set_data(self.entity, self.data)
end
