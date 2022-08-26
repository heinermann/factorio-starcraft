local Entity = require('__stdlib__/stdlib/entity/entity')

local AnimManager = {}


-- We need a way to do RotatedAnimationVariations on cars, but they only support RotatedAnimation (no good).
-- Cars do not support all the other animation types we need.
--
-- So the solution is to create an animation prototype for each variation in each direction (variations*32).
-- In many cases there will be overlap (such as the idle and movement anims of non-bio air units)
--
-- These anims will be named "<entity prototype name>-<variation>-<orientation>" (orientation is between 0 and 31)
-- Variations will include Idle, Moving, Ground Atk, Air Atk, Cloak, Decloak
--
-- Burrow/Unburrow/Siege/Unsiege will take the form of an entity replacement
-- (replaced by a simple-entity-with-force or turret for tanks/lurkers)

local ANIMS = {
  ["starcraft-scout"] = {
    render_main = "146", -- see elevation.md
    render_shadow = "137", -- TODO not sure which level the shadow should be but we can change it later
  }
}

local function get_anim_name(entity, variation)
  return entity.name .. "-anim-" .. variation .. "-" .. str(math.floor(orientation))
end

local function get_entity_state(entity)
  if entity.active then
    if entity.shooting_state ~= defines.shooting.not_shooting then
      return "attacking"
    elseif entity.riding_state.acceleration == defines.riding.acceleration.accelerating then
      return "moving"
    end
  end
  return "idle"
end

-- Update entity when its orientation changes
function AnimManager.update_entity(entity)
  local gfx = ANIMS[entity.name]
  if not gfx then return end

  local data = Entity.get_data(entity)

  rendering.set_animation(data.main_graphic, get_anim_name(entity, get_entity_state(entity)))
  rendering.set_animation(data.shadow_graphic, get_anim_name(entity, "shadow"))
end

function AnimManager.cloak(entity)
  -- TODO
end

function AnimManager.decloak(entity)
  -- TODO
end

function AnimManager.add(entity)
  local gfx = GRAPHICS[entity.name]
  if not gfx then return end
  
  local data = Entity.get_data(entity) or {}
  
  data.main_graphic = rendering.draw_animation({
    animation = get_anim_name(entity, "idle"),
    render_layer = gfx.render_main, -- see elevation.md
    target = entity,
    surface = entity.surface,
    animation_speed = 0
  })

  data.shadow_graphic = rendering.draw_animation({
    animation = get_anim_name(entity, "shadow"),
    render_layer = gfx.render_shadow, -- TODO not sure which level the shadow should be but we can change it later
    target = entity,
    surface = entity.surface,
    animation_speed = 0
  })

  Entity.set_data(entity, data)
end

return GraphicManager
