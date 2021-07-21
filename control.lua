-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local Entity = require('__stdlib__/stdlib/entity/entity')
local iscript = require("iscript.iscript")
local Log = require('__stdlib__/stdlib/misc/logger').new("control")

local g_iscript_entities = {}

local game_just_loaded = false

----------------------------------------------
-- Called once every time the game is loaded, but not when it's first started
-- Should never modify `global`
script.on_load(function()
  game_just_loaded = true
end)

----------------------------------------------


function create_new_force(forcename)
  Log.log("Creating " .. forcename)
  newforce = game.create_force(forcename)

  newforce.disable_research()
  newforce.disable_all_prototypes()
  newforce.ai_controllable = false
end

----------------------------------------------
-- Called once when the game is originally created or mod injected, never after even if the game is loaded
script.on_init(function()
  create_new_force("terran")
  create_new_force("protoss")
  create_new_force("zerg")

  global.iscript_tracking = {}
end)

----------------------------------------------

function get_unit_grid(entity)
  return entity.get_inventory(defines.inventory.character_armor)[1].grid
end

function get_unit_weapons_inventory(entity)
  return entity.get_inventory(defines.inventory.character_guns)
end

function setup_unit_inventory(entity)
  entity.get_inventory(defines.inventory.character_armor).insert({name = "starcraft-armor"})
  
  grid = get_unit_grid(entity)
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

function create_unit(position, force, surface)
  surface = surface or "nauvis"

  baseunit = game.surfaces[surface].create_entity{ name = "starcraft-unit-base", position = position, force = force }
  baseunit.color = {44.0/256, 180.0/256, 148.0/256, 1}

  setup_unit_inventory(baseunit)

  return baseunit
end

function test_of_the_day(event)
  --if event.tick == 0 then
  --  global.testunit = create_unit({2, 0}, "terran")
  --end
--
  --target_rate = math.floor(event.tick / 30)
  --global.testunit.walking_state = {walking = true, direction = (target_rate % 8)}

  --game.surfaces["nauvis"].
end


function register_iscript_entity(entity)
  g_iscript_entities[entity] = true
  iscript.init_obj_data(entity)
  iscript.play_anim(entity, "Init")
  Log.log("Registered " .. entity.name .. " for iscript")
end

local supported_iscript_entity_names = {
  "starcraft-vespene-geyser"
}

function on_game_loaded()
  for _, surface in pairs(game.surfaces) do
    entities = surface.find_entities_filtered{
      name = supported_iscript_entity_names,
      type = {"resource"}
    }

    for _, entity in pairs(entities) do
      register_iscript_entity(entity)
    end
  end
end

--------------------------------------
script.on_nth_tick(1, function(event)
  test_of_the_day(event)

  if game_just_loaded then
    game_just_loaded = false
    on_game_loaded()
  end

  for entity, _ in pairs(g_iscript_entities) do
    iscript.advance(entity)
  end

  local cannons = game.surfaces["nauvis"].find_entities_filtered{
    type = {"turret", "ammo-turret", "electric-turret"}
  }

  for _, c in ipairs(cannons) do
    c.shooting_target = {}
    c.energy = 0
  end

  local fluid_turrets = game.surfaces["nauvis"].find_entities_filtered{
    type = "fluid-turret"
  }
  for _, c in ipairs(fluid_turrets) do
    c.shooting_target = {}
    c.energy = 0
    c.clear_fluid_inside()
    c.insert_fluid{
      name = "water",
      amount = 1000
    }
  end

end)

script.on_nth_tick(300, function(event)
  Log.write()

  --if event.tick > 0 and event.tick < 600 then
  --  cannons = game.surfaces["nauvis"].find_entities_filtered{
  --    type = "turret",
  --    name = "starcraft-cannon"
  --  }
--
  --  for _, c in ipairs(cannons) do
  --    c.shooting_target = c
  --    c.active = false
  --  end
  --end
--
  --if event.tick > 800 and event.tick < 1400 then
  --  cannons = game.surfaces["nauvis"].find_entities_filtered{
  --    type = "turret",
  --    name = "starcraft-cannon"
  --  }
--
  --  for _, c in ipairs(cannons) do
  --    c.active = true
  --    c.shooting_target = c
  --  end
  --end
end)

-- Destroy decoratives that spawn on minerals and vespene geysers, as well as other post-processing
script.on_event(defines.events.on_chunk_generated, function(event)
  resources = event.surface.find_entities_filtered{
    area = event.area,
    name = {"starcraft-mineral-field", "starcraft-vespene-geyser"},
    type = "resource",
    force = "neutral"
  }

  for _, resource in pairs(resources) do
    if not resource.valid then
      goto continue
    end

    event.surface.destroy_decoratives{area = resource.selection_box}

    if resource.name == "starcraft-vespene-geyser" then
      register_iscript_entity(resource)

      gas_box = resource.bounding_box
      minerals_filter = {
        name = "starcraft-mineral-field",
        type = "resource",
        force = "neutral"
      }

      -- Define bounds to search from this geyser
      left_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.left_top.x, gas_box.right_bottom.y + 32}}
      top_bounds = {{gas_box.left_top.x - 32, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.left_top.y}}
      right_bounds = {{gas_box.right_bottom.x, gas_box.left_top.y - 32}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
      bottom_bounds = {{gas_box.left_top.x - 32, gas_box.right_bottom.y}, {gas_box.right_bottom.x + 32, gas_box.right_bottom.y + 32}}
      all_bounds = {left_bounds, top_bounds, right_bounds, bottom_bounds}
      
      -- Find the side of the geyser with the least minerals
      best_count = math.huge
      best_bounds = left_bounds
      for _, area in pairs(all_bounds) do
        minerals_filter.area = area
        count = event.surface.count_entities_filtered(minerals_filter)
        if count < best_count then
          best_count = count
          best_bounds = area
        end
      end

      -- remove minerals from the side of the geyser that has the least
      minerals_filter.area = best_bounds
      for _, entity in pairs(event.surface.find_entities_filtered(minerals_filter)) do
        entity.deplete()
      end

    end
    ::continue::
  end
end)
