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

script.on_nth_tick(2, function(event)
  test_entities = game.surfaces['nauvis'].find_entities_filtered{force = "terran"}
  
  for i, v in pairs(test_entities) do
    if global.main_graphic[v] == nil then
      print("Created")
      global.main_graphic[v] = rendering.draw_animation{
        animation = "test-civ",
        target = v,
        surface = v.surface,
        animation_speed = 0
      }

      rendering.set_animation_offset(global.main_graphic[v], 5)
    end
  end
end)
