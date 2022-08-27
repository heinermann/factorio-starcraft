local table = require('__stdlib__/stdlib/utils/table')
require("prototypes.entity.helpers")

local blank_anim = {
  filename = "__starcraft__/graphics2/blank.png",
  frame_count = 1,
  size = {1, 1},
  direction_count = 1
}

local function create_rotated_anim_variation(protodata, direction)
  local proto = {
    type = "animation",
    name = protodata.basename .. tostring(direction),
    layers = {}
  }

  for _, layer in ipairs(protodata.layers) do
    local basedir = layer.basedir or 0
    local hr_basedir = layer.hr_basedir or 0

    layer.y = (direction - basedir) * layer.size[2]
    layer.hr_y = (direction - hr_basedir) * layer.hr_size[2]

    table.insert(proto.layers, create_anim(layer))
  end
  data:extend({proto})
end

local function copy_and_name(protodata, basename)
  local result = table.deep_copy(protodata)
  result.basename = basename
  return result
end

local function update_frames(protodata, framedata)
  for _, layer in ipairs(protodata.layers) do
    layer.frame_count = framedata.frame_count
    layer.frame_sequence = framedata.frame_sequence
  end
end

------------------------------------------------------------------------------
-- SCOUT DATA
------------------------------------------------------------------------------
local scout_data = {
  size = { 115, 84 },
  hr_size = { 230, 166 },
  vshift = -7/16
}

local scout_engine_data = {
  size = { 193, 156 },
  hr_size = { 386, 314 },
  vshift = -7/16,
}

local scout_base_data_l1 = {
  layers = {
    table.dictionary_merge({
      filename = "main_140_diffuse.png"
    }, scout_data)
  }
}

local scout_base_data_l2 = {
  layers = {
    table.dictionary_merge({
      filename = "main_140_teamcolor.png",
      apply_runtime_tint = true
    }, scout_data)
  }
}

local scout_base_data_l3 = {
  layers = {
    table.dictionary_merge({
      filename = "main_140_emissive.png",
      blend_mode = "additive",
      draw_as_light = true
    }, scout_data)
  }
}

local scout_shadow_data = {
  basename = "starcraft-scout-anim-shadow-",
  layers = {
    {
      filename = "main_140_shadow.png",
      size = { 117, 92 },
      hr_size = { 232, 184 },
      vshift = 3,
      hshift = 3,
      draw_as_shadow = true
    }
  }
}

------------------------------------------------------------------------------
-- SCOUT IDLE (TODO: investigate hover here instead of in code, using stripes)
------------------------------------------------------------------------------
local scout_idle1_data = copy_and_name(scout_base_data_l1, "starcraft-scout-anim-idle1-")
local scout_idle2_data = copy_and_name(scout_base_data_l2, "starcraft-scout-anim-idle2-")
local scout_idle3_data = copy_and_name(scout_base_data_l3, "starcraft-scout-anim-idle3-")
for i = 0, 31 do
  create_rotated_anim_variation(scout_idle1_data, i)
  create_rotated_anim_variation(scout_idle2_data, i)
  create_rotated_anim_variation(scout_idle3_data, i)
end

------------------------------------------------------------------------------
-- SCOUT MOVING (w/ engine)
------------------------------------------------------------------------------
local scout_moving3_data = copy_and_name(scout_base_data_l3, "starcraft-scout-anim-moving3-")
for _, layer in ipairs(scout_moving3_data.layers) do
  layer.repeat_count = 4
end
table.insert(scout_moving3_data.layers, table.dictionary_merge({
  filename = "main_142_diffuse.png",
  hr_filename = "main_142_diffuse_1.png",
  draw_as_glow = true,
  frame_count = 2,
  frame_sequence = {1, 1, 2, 2}
}, scout_engine_data))

for i = 0, 25 do
  create_rotated_anim_variation(scout_moving3_data, i)
end

-- Remaining engine frames are on another sheet
scout_moving3_data.layers[#scout_moving3_data.layers].hr_filename = "main_142_diffuse_2.png"
scout_moving3_data.layers[#scout_moving3_data.layers].hr_basedir = 26
for i = 26, 31 do
  create_rotated_anim_variation(scout_moving3_data, i)
end

------------------------------------------------------------------------------
-- SCOUT SHADOW
------------------------------------------------------------------------------
for i = 0, 31 do
  create_rotated_anim_variation(scout_shadow_data, i)
end

------------------------------------------------------------------------------
-- SCOUT GROUND ATTACK
------------------------------------------------------------------------------
local ground_atk_framedata = {
  frame_count = 2,
  frame_sequence = { 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 }
}

local scout_grnd_atk1_data = copy_and_name(scout_base_data_l1, "starcraft-scout-anim-groundatk1-")
update_frames(scout_grnd_atk1_data, ground_atk_framedata)

local scout_grnd_atk2_data = copy_and_name(scout_base_data_l2, "starcraft-scout-anim-groundatk2-")
update_frames(scout_grnd_atk2_data, ground_atk_framedata)

local scout_grnd_atk3_data = copy_and_name(scout_base_data_l2, "starcraft-scout-anim-groundatk3-")
update_frames(scout_grnd_atk3_data, ground_atk_framedata)

for i = 0, 31 do
  create_rotated_anim_variation(scout_grnd_atk1_data, i)
  create_rotated_anim_variation(scout_grnd_atk2_data, i)
  create_rotated_anim_variation(scout_grnd_atk3_data, i)
end

------------------------------------------------------------------------------
-- SCOUT AIR ATTACK
------------------------------------------------------------------------------
local air_atk_framedata = {
  frame_count = 2,
  frame_sequence = { 2, 2, 1, 1 }
}

local scout_air_atk1_data = copy_and_name(scout_base_data_l1, "starcraft-scout-anim-airatk1-")
update_frames(scout_air_atk1_data, air_atk_framedata)

local scout_air_atk2_data = copy_and_name(scout_base_data_l2, "starcraft-scout-anim-airatk2-")
update_frames(scout_air_atk2_data, air_atk_framedata)

local scout_air_atk3_data = copy_and_name(scout_base_data_l2, "starcraft-scout-anim-airatk3-")
update_frames(scout_air_atk3_data, air_atk_framedata)

for i = 0, 31 do
  create_rotated_anim_variation(scout_air_atk1_data, i)
  create_rotated_anim_variation(scout_air_atk2_data, i)
  create_rotated_anim_variation(scout_air_atk3_data, i)
end

------------------------------------------------------------------------------
-- SCOUT UNIT
------------------------------------------------------------------------------
data:extend({
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
    created_script = "on_protoss_air_unit_created",
    dying_script = "on_protoss_unit_destroyed",
    stop_script = "on_protoss_air_unit_stopped"
  }
})
