require("factorio_libs.UpdateManager")
require("factorio_libs.EntitySet")

local Entity = require('__stdlib__/stdlib/entity/entity')

local AirUnitManager = {}
local air_unit_entities = EntitySet:new("AirUnitManager")

local target_tracker = UpdateManager:new("AirUnitTargetTracker")

local unit_data = nil
local unit = nil

local function set_entity(entity)
  unit = entity
  unit_data = Entity.get_data(entity)
end


local function update_target(entity)
  if entity == nil or not entity.valid or not air_unit_entities:contains(entity) then return end

  set_entity(entity)
  -- TODO do targetting stuff
end

------------------------------------------------------------------------------------------------------------------------------------------
-- Air Unit management
------------------------------------------------------------------------------------------------------------------------------------------

function AirUnitManager.on_update()
  target_tracker:update(update_target)
end

function AirUnitManager.add(entity)
  air_unit_entities:insert(entity)
  target_tracker:add(entity, 8)
end

function AirUnitManager.remove(entity)
  air_unit_entities:remove(entity)
end


return AirUnitManager
