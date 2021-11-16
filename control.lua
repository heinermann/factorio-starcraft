-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local Surface = require('__stdlib__/stdlib/area/surface')
local Entity = require('__stdlib__/stdlib/entity/entity')

local Log = require('__stdlib__/stdlib/misc/logger').new("control")

local Resources = require('src.resources')
local Forces = require('src.forces')
local CUnitProtoss = require('src.CUnitProtoss')
local CUnitPBuild = require('src.CUnitPBuild')
local CUnitZerg = require('src.CUnitZerg')
local ShieldManager = require('src.ShieldManager')
local BldgFireManager = require('src.BldgFireManager')

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
  Resources.on_update()
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
    Resources.setup_resource(entity)
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

local function assimilator_created(entity)
  Resources.register_gas_building(entity)
  CUnitProtoss.on_bldg_created(entity)
end

local function init_starcraft_actor(entity)
  local actor = entity.surface.create_entity{
    name = "starcraft-actor",
    position = entity.position,
    force = entity.force,
    create_build_effect_smoke = false
  }

  entity.set_driver(actor)
end

local function on_protoss_unit_created(entity)
  init_starcraft_actor(entity)
  ShieldManager.init_shields(entity) -- TODO: Move to equipment grid for performance? Still need shield overlays though
end

local function on_protoss_unit_destroyed(entity)
  ShieldManager.unregister_shield_entity(entity)
  entity.get_driver().destroy()
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
  ["on_vespene_geyser_created"] = Resources.register_gas_building,
  ["on_assimilator_created"] = assimilator_created,
  ["on_extractor_created"] = Resources.register_gas_building,
  ["on_protoss_unit_created"] = on_protoss_unit_created,
  ["on_protoss_unit_destroyed"] = on_protoss_unit_destroyed,
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
-- On entity damaged, handling shields and damage overlays
---------------------------------------------------------------------------------------------------------------------
-- TODO: Move shields logic to separate shield management mod?

local function on_entity_damaged(event)
  ShieldManager.on_damaged(event)
  if event.entity.valid then
    BldgFireManager.update_overlays(event.entity)
  end
end

script.on_event(defines.events.on_entity_damaged, on_entity_damaged, {
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
  {filter = "name", name = "starcraft-shield-battery-warp-fade"},
  {filter = "name", name = "starcraft-khaydarin-crystal-formation"},

  {filter = "name", name = "starcraft-probe"},

  {filter = "name", name = "starcraft-cerebrate"},
  {filter = "name", name = "starcraft-daggoth"},
  {filter = "name", name = "starcraft-infested-command-center"},
  {filter = "name", name = "starcraft-spawning-pool"},
  {filter = "name", name = "starcraft-evo-chamber"},
  {filter = "name", name = "starcraft-creep-colony"},
  {filter = "name", name = "starcraft-hatchery"},
  {filter = "name", name = "starcraft-hive"},
  {filter = "name", name = "starcraft-lair"},
  {filter = "name", name = "starcraft-sunken-colony"},
  {filter = "name", name = "starcraft-greater-spire"},
  {filter = "name", name = "starcraft-defiler-mound"},
  {filter = "name", name = "starcraft-queens-nest"},
  {filter = "name", name = "starcraft-nydus"},
  {filter = "name", name = "starcraft-ultra-cavern"},
  {filter = "name", name = "starcraft-extractor"},
  {filter = "name", name = "starcraft-hydra-den"},
  {filter = "name", name = "starcraft-spire"},
  {filter = "name", name = "starcraft-spore-colony"},

  {filter = "name", name = "starcraft-academy"},
  {filter = "name", name = "starcraft-barracks"},
  {filter = "name", name = "starcraft-armory"},
  {filter = "name", name = "starcraft-comsat"},
  {filter = "name", name = "starcraft-command-center"},
  {filter = "name", name = "starcraft-depot"},
  {filter = "name", name = "starcraft-control-tower"},
  {filter = "name", name = "starcraft-factory"},
  {filter = "name", name = "starcraft-covert-ops"},
  {filter = "name", name = "starcraft-machine-shop"},
  {filter = "name", name = "starcraft-turret"},
  {filter = "name", name = "starcraft-crashed-norad"},
  {filter = "name", name = "starcraft-physics-lab"},
  {filter = "name", name = "starcraft-bunker"},
  {filter = "name", name = "starcraft-refinery"},
  {filter = "name", name = "starcraft-science-facility"},
  {filter = "name", name = "starcraft-nuke-silo"},
  {filter = "name", name = "starcraft-starport"},
  {filter = "name", name = "starcraft-engineering-bay"},
})
