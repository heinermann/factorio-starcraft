-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local iscript = require("iscript.iscript")
local Log = require('__stdlib__/stdlib/misc/logger').new("control")

local Resources = require('src.resources')
local Forces = require('src.forces')
local CUnitProtoss = require('src.CUnitProtoss')
local CUnitZerg = require('src.CUnitZerg')

local game_just_loaded = false

---------------------------------------------------------------------------------------------------------------------
-- ON_LOAD
---------------------------------------------------------------------------------------------------------------------
-- Called once every time the game is loaded, but not when it's first started
-- Should never modify `global`
script.on_load(function()
  game_just_loaded = true
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
  if game_just_loaded then
    game_just_loaded = false
    iscript.on_load()
    CUnitZerg.on_load()
  end

  iscript.update()
  CUnitZerg.on_update()
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

local script_lookup = {
  ["on_protoss_pylon_destroyed"] = CUnitProtoss.on_pylon_destroyed,
  ["on_protoss_pylon_created"] = CUnitProtoss.on_pylon_created,
  ["on_protoss_powered_bldg_created"] = CUnitProtoss.on_powered_bldg_created,
  ["on_creep_provider_created"] = CUnitZerg.on_creep_provider_created,
  ["on_creep_provider_destroyed"] = CUnitZerg.on_creep_provider_destroyed,
}

script.on_event(defines.events.on_script_trigger_effect, function(event)
  local fn = script_lookup[event.effect_id]
  local entity = event.target_entity or event.source_entity

  if fn then
    fn(entity)
  end
end)

