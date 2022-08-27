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
    ["idle"] = {
      main = {"starcraft-scout-anim-idle1-", "starcraft-scout-anim-idle2-", "starcraft-scout-anim-idle3-"},
      shadow = "starcraft-scout-anim-shadow-"
    },
    ["moving"] = {
      main = {"starcraft-scout-anim-idle1-", "starcraft-scout-anim-idle2-", "starcraft-scout-anim-moving3-"},
      shadow = "starcraft-scout-anim-shadow-"
    },
    ["ground_atk"] = {
      main = {"starcraft-scout-anim-groundatk1-", "starcraft-scout-anim-groundatk2-", "starcraft-scout-anim-groundatk3-"},
      shadow = "starcraft-scout-anim-shadow-"
    },
    ["air_atk"] = {
      main = {"starcraft-scout-anim-airatk1-", "starcraft-scout-anim-airatk2-", "starcraft-scout-anim-airatk3-"},
      shadow = "starcraft-scout-anim-shadow-"
    }
  }
}

local function get_anim_name(entity, variation, level)
  return ANIMS[entity.name][variation].main[level] .. tostring(math.floor(entity.orientation * 32))
end

local function get_shadow_name(entity, variation)
  return ANIMS[entity.name][variation].shadow .. tostring(math.floor(entity.orientation * 32))
end

local function get_entity_state(entity)
  if entity.active then
    if entity.shooting_state ~= defines.shooting.not_shooting then
      return "attacking" -- TODO: replace with ground or air
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
  local entitystate = get_entity_state(entity)

  for i = 1, 3 do
    rendering.set_animation(data.main_graphics[i], get_anim_name(entity, entitystate, i))
  end
  rendering.set_animation(data.shadow_graphic, get_shadow_name(entity, entitystate))
end

function AnimManager.cloak(entity)
  -- TODO
end

function AnimManager.decloak(entity)
  -- TODO
end

function AnimManager.add(entity)
  local gfx = ANIMS[entity.name]
  if not gfx then return end
  
  local data = Entity.get_data(entity) or {}

  data.main_graphics = {
    rendering.draw_animation({
      animation = get_anim_name(entity, "idle", 1),
      render_layer = gfx.render_main,
      target = entity,
      surface = entity.surface
    }),
    rendering.draw_animation({
      animation = get_anim_name(entity, "idle", 2),
      render_layer = gfx.render_main,
      target = entity,
      surface = entity.surface,
      tint = entity.force.color
    }),
    rendering.draw_animation({
      animation = get_anim_name(entity, "idle", 3),
      render_layer = gfx.render_main,
      target = entity,
      surface = entity.surface
    }),
  }

  data.shadow_graphic = rendering.draw_animation({
    animation = get_shadow_name(entity, "idle"),
    render_layer = gfx.render_shadow,
    target = entity,
    surface = entity.surface
  })

  Entity.set_data(entity, data)
end

return AnimManager
