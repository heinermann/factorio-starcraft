-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

local Entity = require('__stdlib__/stdlib/entity/entity')


function create_new_force(forcename)
  newforce = game.create_force(forcename)

  newforce.disable_research()
  newforce.disable_all_prototypes()
  newforce.ai_controllable = false


  global.forces[forcename] = newforce
end


script.on_init(function()
  global.forces = {}

  game.create_force("terran")
  game.create_force("protoss")
  game.create_force("zerg")

  global.main_graphic = {}
end)

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

function attach_ol(entity, anim, tint)
  -- "128" or "127" for ul and ""
  rendering.draw_animation{
    animation = anim,
    target = entity,
    surface = entity.surface,
    render_layer = "object",  -- air-object for air unit
    animation_speed = 0,
    tint = tint,
    target_offset = {0, -9.0/16}
  }
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

  --baseunit.orientation = 0
  --baseunit.direction = defines.direction.north
  --baseunit.direction = 8

  --attach_ol(baseunit, "starcraft_main_221")
  --attach_ol(baseunit, "starcraft_main_221_teamcolor", baseunit.color)
  return baseunit
end

directions = {
  defines.direction.north,
  defines.direction.northeast,
  defines.direction.east,
  defines.direction.southeast,
  defines.direction.south,
  defines.direction.southwest,
  defines.direction.west,
  defines.direction.northwest
}

script.on_nth_tick(2, function(event)
  if event.tick == 0 then
    global.testunit = create_unit({2, 0}, "terran")
  end

  target_rate = math.floor(event.tick / 30)
  global.testunit.walking_state = {walking = true, direction = directions[(target_rate % #directions) + 1]}
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
      best_count = 10000
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
