require("__starcraft__/external/class/class")
require("Orders")

local Entity = require('__starcraft__/external/stdlib/entity/entity')
local HoverManager = require('src.HoverManager')

-- Once this is done with, must call saveData()
AirUnit = class()

function AirUnit:init(entity)
    self.entity = entity
    self:restoreData()
end

function AirUnit:createInit()

end

function AirUnit:restoreData()
    self.data = Entity.get_data(self.entity) or {}
end

function AirUnit:writeData()
    Entity.set_data(self.entity, self.data)
end

-- TODO: Make into a manager (some ground units have movement engines/jets too)
function AirUnit:showEngines()
    -- TODO: jets overlay
end

function AirUnit:hideEngines()
    -- TODO
end

function AirUnit:orderStop()
end

function AirUnit:fullStop()
    self:hideEngines()
    HoverManager.register_for_hovering(self.entity)
end

-- TODO also auto targetting when attacked (see on_entity_damaged in control.lua)
function AirUnit:getAttackTarget()
    -- TODO find an enemy in some range
end

function AirUnit:orderAttackInRange()
    self:hideEngines()
    HoverManager.unregister_for_hovering(self.entity)

end

function AirUnit:orderMove(target)
    HoverManager.unregister_for_hovering(self.entity)

end

function AirUnit:update()
end
