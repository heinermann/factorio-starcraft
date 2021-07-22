-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local Entity = require('__stdlib__/stdlib/entity/entity')
local iscript = require("iscript.iscript")
local Log = require('__stdlib__/stdlib/misc/logger').new("control")
local table = require('__stdlib__/stdlib/utils/table')
local Surface = require('__stdlib__/stdlib/area/surface')

require('src.resources')
require('src.forces')

local game_just_loaded = false

----------------------------------------------
-- Called once every time the game is loaded, but not when it's first started
-- Should never modify `global`
script.on_load(function()
  game_just_loaded = true
end)

----------------------------------------------
-- Called once when the game is originally created or mod injected, never after even if the game is loaded
script.on_init(function()
  create_forces()
  global.iscript_tracking = {}
end)

----------------------------------------------
-- TODO: Deal with this stuff
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

-- What a nightmare this is going to be
-- Cons of unit:
--  - Biter AI still has some control
--  - Can't programmatically switch weapons or take direct movement control
--  - Limited facing directions
-- Cons of car:
--  - Not targetable
--  - Shows in UI as a vehicle
-- Cons of character:
--  - Limited facing directions
--  - Anim bug that tries to load additional graphics out of a sheet
local function create_unit(position, force, surface)
  surface = surface or "nauvis"

  local baseunit = game.surfaces[surface].create_entity{ name = "starcraft-unit-base", position = position, force = force }
  baseunit.color = {44.0/256, 180.0/256, 148.0/256, 1}

  setup_unit_inventory(baseunit)

  return baseunit
end

--------------------------------------
script.on_nth_tick(1, function(event)
  if game_just_loaded then
    game_just_loaded = false
    iscript.on_load()
  end

  iscript.update()
end)

script.on_nth_tick(300, function(event)
  Log.write()
end)

-- Destroy decoratives that spawn on minerals and vespene geysers, as well as other post-processing
script.on_event(defines.events.on_chunk_generated, function(event)
  local resources = event.surface.find_entities_filtered{
    area = event.area,
    name = {"starcraft-mineral-field", "starcraft-vespene-geyser"},
    type = "resource",
    force = "neutral"
  }

  for _, entity in ipairs(resources) do
    setup_resource(entity, iscript)
  end
end)
