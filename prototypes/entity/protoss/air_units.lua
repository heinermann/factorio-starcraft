local table = require('__stdlib__/stdlib/utils/table')
require("prototypes.entity.helpers")

local blank_anim = {
  filename = "__starcraft__/graphics2/blank.png",
  frame_count = 1,
  size = {1, 1},
  direction_count = 1
}

-- TODO stripes (dual-sheets support)
local function create_rotated_anim_variations(basename, variation, data, engine_data)
  for i = 0, 31 do
    data.y = i * data.size[2]
    data.hr_y = i * data.hr_size[2]

    if engine_data then
      engine_data.y = i * engine_data.size[2]
      engine_data.hr_y = i * engine_data.hr_size[2]
    end

    local anim_definition = {
      type = "animation",
      name = basename .. "-anim-" .. variation .. "-" .. str(i),
      layers = {
        create_anim(table.dictionary_merge({
          filename = (data.filename or (data.name .. "_diffuse")) .. ".png"
        }, data)),
      }
    }

    if not data.draw_as_shadow then
      table.insert(anim_definition.layers, create_anim(table.dictionary_merge({
        filename = data.name .. "_teamcolor.png",
        apply_runtime_tint = true,
      }, data)))
    end

    if not data.draw_as_shadow and data.has_emissive then
      table.insert(anim_definition.layers, create_anim(table.dictionary_merge({
        filename = data.name .. "_emissive.png",
        blend_mode = "additive",
        draw_as_light = true
      }, data)))
    end

    if not data.draw_as_shadow and engine_data then
      table.insert(anim_definition.layers, create_anim(table.dictionary_merge({
        filename = engine_data.name .. "_diffuse.png",
        draw_as_glow = true
      }, engine_data)))
    end

    data:extend(anim_definition)
  end
end

create_rotated_anim_variations("starcraft-scout", "idle", {
  name = "main_140",
  size = { 115, 84 },
  hr_size = { 230, 166 },
  vshift = -7/16,
  has_emissive = true
})
create_rotated_anim_variations("starcraft-scout", "moving", {
  name = "main_140",
  size = { 115, 84 },
  hr_size = { 230, 166 },
  vshift = -7/16,
  has_emissive = true
},{

})
create_rotated_anim_variations("starcraft-scout", "shadow", {
  filename = "main_140_shadow",
  size = { 117, 92 },
  hr_size = { 232, 184 },
  vshift = 3,
  hshift = 3,
  draw_as_shadow = true
})

data:extend({
  { -- TODO: Replace
    type = "animation",
    name = "starcraft-scout-anim-ground-attack",
    layers = {
      create_layered_anim({
        name = "main_140",
        size = { 115, 84 },
        hr_size = { 230, 166 },
        vshift = -7/16,
        direction_count = 32,
        frame_count = 2,
        frame_sequence = { 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 },
      }, {"main", "teamcolor", "emissive"})
    }
  },
  { -- TODO: Replace
    type = "animation",
    name = "starcraft-scout-anim-air-attack",
    layers = {
      create_layered_anim({
        name = "main_140",
        size = { 115, 84 },
        hr_size = { 230, 166 },
        vshift = -7/16,
        direction_count = 32,
        frame_count = 2,
        frame_sequence = { 2, 2, 1, 1 },
      }, {"main", "teamcolor", "emissive"})
    }
  },
  make_protoss_air_unit{
    name = "starcraft-scout",
    icon_id = 70,
    collision_box = sc_bounds_to_factorio{18, 16, 17, 15},
    --dying_explosion = "starcraft-scout-death",
    max_health = 150,
    size_type = "large",

    rotation_speed = 0.015,
    braking_force = 1,      -- or braking_power
    terrain_friction_modifier = 0,
    friction_force = 0.09733887815,
    weight = 1,
    effectivity = 1,
    consumption = tostring(32.8868891*60) .. "W",

    animation = blank_anim,
    render_layer = "air-entity-info-icon", -- Should be "146" instead but that is invalid here
    created_script = "on_scout_created",
    dying_script = "on_protoss_unit_destroyed",
    --stop_script = "return_to_idle_anim"
  }
})
