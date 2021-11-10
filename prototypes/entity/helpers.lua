local table = require('__stdlib__/stdlib/utils/table')

local unitSizeTypes = {
  independent = {
    { type = "physical", percent = 99 },
    { type = "impact", percent = 99 },
    { type = "explosion", percent = 99 },
    { type = "fire", percent = 99 },
    { type = "laser", percent = 99 },
    { type = "acid", percent = 99 },
    { type = "electric", percent = 99 },
    { type = "psionic", percent = 99 }
  },
  small = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 0 },
    { type = "explosion", percent = 50 },
    { type = "fire", percent = 0 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 50 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  },
  medium = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 50 },
    { type = "explosion", percent = 25 },
    { type = "fire", percent = 50 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 25 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  },
  large = {
    { type = "physical", percent = 0 },
    { type = "impact", percent = 75 },
    { type = "explosion", percent = 0 },
    { type = "fire", percent = 75 },
    { type = "laser", percent = 0 },
    { type = "acid", percent = 0 },
    { type = "electric", percent = 0 },
    { type = "psionic", percent = 0 }
  }
}

local function make_resistances(unit_size_type, armor_amount)
  local result = table.deep_copy(unitSizeTypes[unit_size_type])
  for _, resist in ipairs(result) do
    if (resist.type ~= "psionic") then
      resist.decrease = armor_amount
    end
  end

  return result
end

function create_ground_unit(data)
  
end

function sc_ticks_to_factorio_ticks(value)
  return (value * 42) / 1000 / (1 / 60)
end
-- 924ms 
function sc_tiles_per_frame_to_factorio_tiles_per_tick(value)
  -- 2.52 tick/frame = 42ms/frame / (1000ms/s / 60tick/s)
  return (value * 2) / 2.52
end

function sc_pixels_to_factorio_tiles(value)
  return value / 32 * 2
end

function sc_tiles_to_factorio_tiles(value)
  return value * 2
end

function sc_pixels_per_frame_to_factorio_tiles_per_tick(value)
  return sc_tiles_per_frame_to_factorio_tiles_per_tick(value / 32)
end

local function make_common_structure(data)
  local result = {
    --------------------------------------------------------------------
    -- PrototypeBase
    name = data.name,

    --------------------------------------------------------------------
    -- EntityWithHealth
    corpse = data.corpse,
    dying_explosion = data.dying_explosion,
    healing_per_tick = data.healing_per_tick,
    hide_resistances = false,
    max_health = data.max_health,
    repair_speed_modifier = data.repair_speed_modifier,
    resistances = make_resistances("large", data.armor),
    create_ghost_on_death = false,

    --------------------------------------------------------------------
    -- Entity
    icon = data.icon or "__base__/graphics/icons/info.png",
    icon_size = data.icon_size or 64,

    allow_copy_paste = false,
    build_sound = data.build_sound,
    collision_box = data.collision_box,
    collision_mask = {
      "item-layer",
      "object-layer",
      "train-layer",
      "player-layer",
      "water-tile"
    },

    fast_replaceable_group = data.fast_replaceable_group,
    flags = {
      "not-rotatable",
      "not-blueprintable",
      "not-deconstructable",
      "hidden",
      "not-flammable",
      "no-automated-item-removal",
      "no-automated-item-insertion",
      "no-copy-paste",
      "not-upgradable",
      "player-creation"
    },

    map_generator_bounding_box = {{-data.tile_width/2, -data.tile_height/2}, {data.tile_width/2, data.tile_height/2}},
    remove_decoratives = "true",
    selection_box = {{-data.tile_width/2, -data.tile_height/2}, {data.tile_width/2, data.tile_height/2}},
    shooting_cursor_size = data.tile_width + 1,
    subgroup = data.subgroup,
    tile_height = data.tile_height,
    tile_width = data.tile_width,
    created_smoke = {
      smoke_name = "starcraft-smokeless"
    }

    -- trigger_target_mask
  }

  if data.created_script then
    result.created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          type = "script",
          effect_id = data.created_script
        }
      }
    }
  end

  if data.damaged_script then
    result.damaged_trigger_effect = {
      type = "script",
      effect_id = data.damaged_script
    }
  end

  if data.dying_script then
    result.dying_trigger_effect = {
      type = "script",
      effect_id = data.dying_script
    }
  end

  if data.icon_id then
    result.icon = "__starcraft__/graphics/cmdicons/" .. tostring(data.icon_id) .. ".png"
    result.icon_size = data.icon_size or 128
  end

  return result
end

function make_functional_turret(data)
  local result = make_common_structure(data)

  local amendments = {
    --------------------------------------------------------------------
    -- PrototypeBase
    type = "turret",

    --------------------------------------------------------------------
    -- Turret
    attack_parameters = data.attack_parameters,
    alert_when_attacking = false,
    attack_target_mask = data.attack_target_mask,
    ignore_target_mask = data.ignore_target_mask,
    prepare_range = data.prepare_range,
    call_for_help_radius = 0,

    folding_animation = data.folding_animation,
    folding_speed = data.folding_speed,

    folded_animation = data.folded_animation,
    folded_speed = data.folded_speed,

    preparing_animation = data.preparing_animation,
    preparing_speed = data.preparing_speed,

    prepared_animation = data.prepared_animation,
    prepared_speed = data.prepared_speed,

    attacking_animation = data.attacking_animation,
    attacking_speed = data.attacking_speed,

    ending_attack_animation = data.ending_attack_animation,
    ending_attack_speed = data.ending_attack_speed,

    starting_attack_animation = data.starting_attack_animation,
    starting_attack_speed = data.starting_attack_speed
  }

  return table.dictionary_merge(result, amendments)
end

-- The following fields for `data` are used:
--
-- name
-- crafting_categories
-- animation
-- working_anim
-- corpse
-- damaged_trigger_effect
-- dying_explosion
-- dying_trigger_effect
-- healing_per_tick
-- max_health
-- repair_speed_modifier
-- build_sound
-- collision_box
-- map_generator_bounding_box
-- subgroup
-- tile_height
-- tile_width
function make_functional_structure(data)
  local result = make_common_structure(data)

  local amendments = {
    --------------------------------------------------------------------
    -- PrototypeBase
    type = "simple-entity-with-force",

    ----------------------------------------------------------------------
    ---- AssemblingMachine
    --ingredient_count = 0,

    ----------------------------------------------------------------------
    ---- CraftingMachine
    --crafting_categories = data.crafting_categories,
    --crafting_speed = 1,
    --energy_source = {
    --  type = "void"
    --},
    --energy_usage = "1W",
    --allowed_effects = { "speed" },
    --animation = data.animation,
    --idle_animation = data.animation,
    --always_draw_idle_animation = false,
    --return_ingredients_on_change = false,
    --show_recipe_icon = false,
    --show_recipe_icon_on_map = false,

    --------------------------------------------------------------------
    -- SimpleEntityWithForce
    animations = data.animation,
    picture = data.picture,
    pictures = data.pictures,
    random_animation_offset = false,
    random_variation_on_create = false
  }

  -- If this were a CraftingMachine
  --if data.working_anim then
  --  result.working_visualisations = {
  --    {
  --      constant_speed = true,
  --      animation = data.working_anim,
  --    }
  --  }
  --end

  return table.dictionary_merge(result, amendments)
end

function create_anim(data)
  local result = {
      filename = "__starcraft__/graphics/low/" .. (data.low_filename or data.filename),
      line_length = data.line_length or data.frame_count or 1,
      size = data.size,
      frame_count = data.frame_count or 1,
      frame_sequence = data.frame_sequence,
      animation_speed = data.animation_speed,
      flags = data.flags,
      draw_as_shadow = data.draw_as_shadow,
      draw_as_glow = data.draw_as_glow,
      draw_as_light = data.draw_as_light,
      apply_runtime_tint = data.apply_runtime_tint,
      blend_mode = data.blend_mode,
      repeat_count = data.repeat_count,
      direction_count = 1,
      shift = data.shift,
      y = data.y,

      hr_version = {
          filename = "__starcraft__/graphics/hd/" .. (data.hr_filename or data.filename),
          line_length = data.hr_line_length or data.frame_count or 1,
          size = data.hr_size,
          scale = 0.5,
          frame_count = data.frame_count or 1,
          frame_sequence = data.frame_sequence,
          animation_speed = data.animation_speed,
          flags = data.flags,
          draw_as_shadow = data.draw_as_shadow,
          draw_as_glow = data.draw_as_glow,
          draw_as_light = data.draw_as_light,
          apply_runtime_tint = data.apply_runtime_tint,
          blend_mode = data.blend_mode,
          repeat_count = data.repeat_count,
          direction_count = 1,
          shift = data.shift,
          y = data.hr_y
    }
  }

  if data.vshift ~= nil or data.hshift ~= nil then
    result.shift = { data.hshift or 0, data.vshift or 0 }
    result.hr_version.shift = result.shift
  end
  return result
end

function create_shadow_anim(data)
  local result = create_anim(data)
  result.filename = "__starcraft__/graphics2/shadows/" .. data.filename .. ".png"
  result.hr_version.filename = "__starcraft__/graphics2/shadows/" .. data.filename .. "_hr.png"
  result.draw_as_shadow = true
  result.hr_version.draw_as_shadow = true
  return result
end

-- NOTE: Shadows unsupported because structure shadows need to be remade from scratch
function create_layered_anim(data, layers)
  local common_attributes = {
    size = data.size,
    line_length = data.line_length,
    hr_size = data.hr_size,
    hr_line_length = data.hr_line_length,
    frame_count = data.frame_count,
    frame_sequence = data.frame_sequence,
    animation_speed = data.animation_speed,
    repeat_count = data.repeat_count,
    shift = data.shift,
    vshift = data.vshift
  }

  return {
    layers = table.map(layers, function(layer)
      if layer == "main" then
        return create_anim(table.dictionary_merge({
            filename = data.name .. "_diffuse.png"
          }, common_attributes))
      elseif layer == "teamcolor" then
        return create_anim(table.dictionary_merge({
          filename = data.name .. "_teamcolor.png",
          apply_runtime_tint = true,
          --flags = { "mask" },
        }, common_attributes))
      elseif layer == "emissive" then
        return create_anim(table.dictionary_merge({
          filename = data.name .. "_emissive.png",
          blend_mode = "additive",
          draw_as_light = true
        }, common_attributes))
      end
    end
    )
  }
end

function sc_bounds_to_factorio(bounds)
  return {{-bounds[1]/16, -bounds[2]/16}, {(bounds[3] + 1)/16, (bounds[4] + 1)/16}}
end

function make_zerg_structure(data)
  local result = make_functional_structure(data)
  result.subgroup = "starcraft-zerg-buildings"
  result.healing_per_tick = 0.0062

  result.flags = {
    "not-repairable",
    table.unpack(result.flags)
  }

  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "on_zerg_bldg_dmg" -- Used to update overlays
  }

  -- This is the magic that makes creep work, since creep tiles collide with object-layer to prevent other structures
  -- from being placed on it, that means structures cannot have object-layer collision (so it has other collision masks to make up for it)
  result.collision_mask = {
    "item-layer",
    "train-layer",
    "player-layer",
    "water-tile"
  }

  return result
end

function protossify_prototype(data)
  data.subgroup = "starcraft-protoss-buildings"

  data.flags = {
    "not-repairable",
    table.unpack(data.flags)
  }
  return data
end

function make_protoss_structure(data)
  return protossify_prototype(make_functional_structure(data))
end

function make_terran_structure(data)
  local result = make_functional_structure(data)
  result.subgroup = "starcraft-terran-buildings"

  -- TODO: repair_speed_modifier

  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "on_terran_bldg_dmg" -- Used to update overlays
  }
  return result
end

function make_projectile(data)
  return {
    --------------------------------------------------------------------
    -- PrototypeBase
    type = "projectile",
    name = data.name,

    --------------------------------------------------------------------
    -- Projectile
    action = data.action,
    animation = data.animation,
    direction_only = data.direction_only,   -- Fly & Follow target or not
    hit_collision_mask = data.hit_collision_mask,
    piercing_damage = data.piercing_damage,
    final_action = data.final_action,
    rotatable = data.rotatable,
    shadow = data.shadow,
    smoke = data.smoke,

    -- Flingy values
    acceleration = data.acceleration,
    max_speed = data.max_speed,
    turn_speed = data.turn_speed,
    turning_speed_increases_exponentially_with_projectile_speed = data.turning_speed_increases_exponentially_with_projectile_speed,

    --------------------------------------------------------------------
    -- Entity
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
  }
end
