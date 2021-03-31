-- Step 3: Control initialization
-- Loaded when: During game
-- Purpose: Mod-specific lua instance which sets up callbacks and everything else.
--
-- https://lua-api.factorio.com/latest/Data-Lifecycle.html

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

function create_unit(position, force, surface)
  surface = surface or "nauvis"

  baseunit = game.surfaces[surface].create_entity{ name = "starcraft-unit-base", position = position, force = force }
  baseunit.color = {44.0/256, 180.0/256, 148.0/256, 1}

  setup_unit_inventory(baseunit)

  baseunit.orientation = 0.25

  attach_ol(baseunit, "starcraft_main_221")
  attach_ol(baseunit, "starcraft_main_221_teamcolor", baseunit.color)
end

script.on_nth_tick(2, function(event)
  if event.tick == 0 then
    create_unit({2, 0}, "terran")

    --test_entities = game.surfaces['nauvis'].find_entities_filtered{force = "terran"}
    --
    --for i, v in pairs(test_entities) do
    --  print("Created")
    --  global.test_anim = rendering.draw_animation{
    --    animation = "starcraft_main_221",
    --    target = v,
    --    surface = v.surface,
    --    render_layer = "object",  -- air-object for air unit
    --    animation_speed = 0
    --  }
    --  global.frame = 0
--
    --  character = v.surface.create_entity{ name = "character", position = v.position, force = v.force }
    --  character.color = {32.0/256, 144.0/256, 112.0/256, 1}
    --  --v.set_driver(character)
--
--
    --  --rendering.set_animation_offset(global.main_graphic[v], 17*6+16)
    --end
  end


  --rendering.set_animation_offset(global.test_anim, 119)

end)
