require("factorio_libs.UpdateManager")
require("factorio_libs.EntitySet")

local Entity = require('__starcraft__/external/stdlib/entity/entity')

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

  -- TODO air vs ground attack
  -- TODO gun max range
  -- TODO don't call this more than once if we have a target (see AAI vehicles for example)
  local target = entity.surface.find_nearest_enemy_entity_with_owner{
    position = entity.position,
    max_distance = 16,
    force = entity.force
  }
  -- TODO check ground and air weapons
  if target ~= nil then
    local driver = entity.get_driver()
    --driver.selected = target
    driver.shooting_state = {
      state = defines.shooting.shooting_enemies,
      position = target.position
    }
  end
  target_tracker:add(entity, 8)
end

------------------------------------------------------------------------------------------------------------------------------------------
-- Air Unit management
------------------------------------------------------------------------------------------------------------------------------------------

function AirUnitManager.on_update()
  target_tracker:update(update_target)
end

function AirUnitManager.add(entity)
  entity.get_inventory(defines.inventory.car_ammo).insert{ name = "starcraft-protoss-air-weapons-ammo" }
  entity.get_inventory(defines.inventory.car_trunk).insert{ name = "starcraft-protoss-air-weapons-ammo" }
  air_unit_entities:insert(entity)
  target_tracker:add(entity, 8)
end

function AirUnitManager.remove(entity)
  air_unit_entities:remove(entity)
end


return AirUnitManager
