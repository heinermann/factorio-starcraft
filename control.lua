-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local Surface = require('__stdlib__/stdlib/area/surface')

local iscript = require("iscript.iscript")
local Log = require('__stdlib__/stdlib/misc/logger').new("control")

local Resources = require('src.resources')
local Forces = require('src.forces')
local CUnitProtoss = require('src.CUnitProtoss')
local CUnitPBuild = require('src.CUnitPBuild')
local CUnitZerg = require('src.CUnitZerg')
local ShieldManager = require('ShieldManager')

---------------------------------------------------------------------------------------------------------------------
-- ON_LOAD
---------------------------------------------------------------------------------------------------------------------
-- Called once every time the game is loaded, but not when it's first started
-- Should never modify `global`
script.on_load(function()
end)

---------------------------------------------------------------------------------------------------------------------
-- ON_INIT
---------------------------------------------------------------------------------------------------------------------
-- Called once when the game is originally created or mod injected, never after even if the game is loaded
script.on_init(function()
  Forces.on_init()
  iscript.on_init()
end)

---------------------------------------------------------------------------------------------------------------------
-- TODO: Deal with this stuff
---------------------------------------------------------------------------------------------------------------------
local function get_unit_grid(entity)
  return entity.get_inventory(defines.inventory.character_armor)[1].grid
end

local function get_unit_weapons_inventory(entity)
  return entity.get_inventory(defines.inventory.character_guns)
end

local function setup_unit_inventory(entity)
  entity.get_inventory(defines.inventory.character_armor).insert({name = "starcraft-armor"})

  local grid = get_unit_grid(entity)
  grid.put({name = "starcraft-energy-src"})
end

local function create_unit(position, force, surface)
  surface = surface or "nauvis"

  local baseunit = game.surfaces[surface].create_entity{ name = "starcraft-unit-base", position = position, force = force }
  baseunit.color = {44.0/256, 180.0/256, 148.0/256, 1}

  setup_unit_inventory(baseunit)

  return baseunit
end

---------------------------------------------------------------------------------------------------------------------
-- ON_NTH_TICK
---------------------------------------------------------------------------------------------------------------------
script.on_nth_tick(1, function(event)
  iscript.update()
  CUnitZerg.on_update()
  CUnitProtoss.on_update()
  CUnitPBuild.on_update()
end)

script.on_nth_tick(300, function(event)
  Log.write()
end)

---------------------------------------------------------------------------------------------------------------------
-- ON_CHUNK_GENERATED
---------------------------------------------------------------------------------------------------------------------
-- Destroy decoratives that spawn on minerals and vespene geysers, as well as other post-processing
script.on_event(defines.events.on_chunk_generated, function(event)
  local resources = event.surface.find_entities_filtered{
    area = event.area,
    name = {"starcraft-mineral-field", "starcraft-vespene-geyser"},
    type = "resource"
  }

  for _, entity in ipairs(resources) do
    Resources.setup_resource(entity, iscript)
  end
end)

---------------------------------------------------------------------------------------------------------------------
-- ON_ENTITY_DIED
---------------------------------------------------------------------------------------------------------------------
-- https://lua-api.factorio.com/latest/events.html#on_entity_died
-- TODO
script.on_event(defines.events.on_entity_died, function(event)
  local entity = event.entity
end)

---------------------------------------------------------------------------------------------------------------------
-- ON_ENTITY_DAMAGED
---------------------------------------------------------------------------------------------------------------------
-- https://lua-api.factorio.com/latest/events.html#on_entity_damaged
-- TODO
script.on_event(defines.events.on_entity_damaged, function(event)
  local entity = event.entity
end)

---------------------------------------------------------------------------------------------------------------------
-- Protoss scripts
---------------------------------------------------------------------------------------------------------------------
-- https://lua-api.factorio.com/latest/events.html#on_script_trigger_effect
-- TODO
local function warp_anchor_placed(entity)
  CUnitProtoss.on_bldg_created(entity)
  CUnitPBuild.add_warp_anchor(entity) -- Must be after on_bldg_created
end

local function warp_anchor_destroyed(entity)
  CUnitPBuild.destroy_warp_anchor(entity)
  CUnitProtoss.on_bldg_destroyed(entity)
end

local script_lookup = {
  ["on_protoss_pylon_destroyed"] = CUnitProtoss.on_pylon_destroyed,
  ["on_protoss_pylon_created"] = CUnitProtoss.on_pylon_created,
  ["on_protoss_powered_bldg_created"] = CUnitProtoss.on_powered_bldg_created,
  ["on_protoss_bldg_created"] = CUnitProtoss.on_bldg_created,
  ["on_protoss_bldg_destroyed"] = CUnitProtoss.on_bldg_destroyed,
  ["on_creep_provider_created"] = CUnitZerg.on_creep_provider_created,
  ["on_creep_provider_destroyed"] = CUnitZerg.on_creep_provider_destroyed,
  ["on_creep_bldg_created"] = CUnitZerg.on_creep_bldg_created,
  ["on_creep_bldg_destroyed"] = CUnitZerg.on_creep_bldg_destroyed,
  ["on_warp_anchor_placed"] = warp_anchor_placed,
  ["on_warp_anchor_destroyed"] = warp_anchor_destroyed,
}

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local fn = script_lookup[event.effect_id]
  local entity = event.target_entity or event.source_entity

  if fn then
    fn(entity)
  end
end)

---------------------------------------------------------------------------------------------------------------------
-- Shield interface
---------------------------------------------------------------------------------------------------------------------
-- TODO: Move to separate shield management mod
remote.add_interface("shields",
  {
    get_shields = CUnitProtoss.get_shields,
    max_shields = CUnitProtoss.max_shields,
    add_shields = CUnitProtoss.add_shields,
    subtract_shields = CUnitProtoss.subtract_shields, -- Returns remaining damage not applied to shields
    set_shields = CUnitProtoss.set_shields,
    get_shield_ratio = CUnitProtoss.get_shield_ratio,
    -- apply_resistance_to_shields (global)
    -- apply_resistance_to_entity_shields
    -- set_max_shields
  }
)

---------------------------------------------------------------------------------------------------------------------
-- Shield management
---------------------------------------------------------------------------------------------------------------------
-- TODO: Move to separate shield management mod

script.on_event(defines.events.on_entity_damaged, ShieldManager.on_damaged, {
  {filter = "name", name = "starcraft-nexus"},
  {filter = "name", name = "starcraft-nexus-warp-anchor"},
  {filter = "name", name = "starcraft-nexus-warp-fade"},
  {filter = "name", name = "starcraft-robotics-facility"},
  {filter = "name", name = "starcraft-robotics-facility-warp-anchor"},
  {filter = "name", name = "starcraft-robotics-facility-warp-fade"},
  {filter = "name", name = "starcraft-pylon"},
  {filter = "name", name = "starcraft-pylon-warp-anchor"},
  {filter = "name", name = "starcraft-pylon-warp-fade"},
  {filter = "name", name = "starcraft-assimilator"},
  {filter = "name", name = "starcraft-assimilator-warp-anchor"},
  {filter = "name", name = "starcraft-assimilator-warp-fade"},
  {filter = "name", name = "starcraft-observatory"},
  {filter = "name", name = "starcraft-observatory-warp-anchor"},
  {filter = "name", name = "starcraft-observatory-warp-fade"},
  {filter = "name", name = "starcraft-gateway"},
  {filter = "name", name = "starcraft-gateway-warp-anchor"},
  {filter = "name", name = "starcraft-gateway-warp-fade"},
  {filter = "name", name = "starcraft-cannon"},
  {filter = "name", name = "starcraft-cannon-warp-anchor"},
  {filter = "name", name = "starcraft-cannon-warp-fade"},
  {filter = "name", name = "starcraft-citadel"},
  {filter = "name", name = "starcraft-citadel-warp-anchor"},
  {filter = "name", name = "starcraft-citadel-warp-fade"},
  {filter = "name", name = "starcraft-cyber-core"},
  {filter = "name", name = "starcraft-cyber-core-warp-anchor"},
  {filter = "name", name = "starcraft-cyber-core-warp-fade"},
  {filter = "name", name = "starcraft-archives"},
  {filter = "name", name = "starcraft-archives-warp-anchor"},
  {filter = "name", name = "starcraft-archives-warp-fade"},
  {filter = "name", name = "starcraft-forge"},
  {filter = "name", name = "starcraft-forge-warp-anchor"},
  {filter = "name", name = "starcraft-forge-warp-fade"},
  {filter = "name", name = "starcraft-stargate"},
  {filter = "name", name = "starcraft-stargate-warp-anchor"},
  {filter = "name", name = "starcraft-stargate-warp-fade"},
  {filter = "name", name = "starcraft-fleet-beacon"},
  {filter = "name", name = "starcraft-fleet-beacon-warp-anchor"},
  {filter = "name", name = "starcraft-fleet-beacon-warp-fade"},
  {filter = "name", name = "starcraft-tribunal"},
  {filter = "name", name = "starcraft-tribunal-warp-anchor"},
  {filter = "name", name = "starcraft-tribunal-warp-fade"},
  {filter = "name", name = "starcraft-robotics-support-bay"},
  {filter = "name", name = "starcraft-robotics-support-bay-warp-anchor"},
  {filter = "name", name = "starcraft-robotics-support-bay-warp-fade"},
  {filter = "name", name = "starcraft-shield-battery"},
  {filter = "name", name = "starcraft-shield-battery-warp-anchor"},
  {filter = "name", name = "starcraft-shield-battery-warp-fade"}
})
