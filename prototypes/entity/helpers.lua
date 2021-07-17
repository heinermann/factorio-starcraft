local table = require('__stdlib__/stdlib/utils/table')

unitSizeTypes = {
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

function create_ground_unit(data)
  
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
  local result = {
    
    --------------------------------------------------------------------
    -- PrototypeBase
    type = "simple-entity-with-force",
    name = data.name,

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
    random_variation_on_create = false,

    --------------------------------------------------------------------
    -- EntityWithHealth
    corpse = data.corpse,
    damaged_trigger_effect = data.damaged_trigger_effect,
    dying_explosion = data.dying_explosion,
    dying_trigger_effect = data.dying_trigger_effect,
    healing_per_tick = data.healing_per_tick,
    hide_resistances = false,
    max_health = data.max_health,
    repair_speed_modifier = data.repair_speed_modifier,
    resistances = unitSizeTypes.large,

    --------------------------------------------------------------------
    -- Entity
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    
    allow_copy_paste = false,
    build_sound = data.build_sound,
    collision_box = data.collision_box,
    collision_mask = {
      "item-layer",
      "object-layer",
      "player-layer",
      "water-tile",
      "resource-layer"
    },

    -- TODO: created_effect ?

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

    -- trigger_target_mask
  }

  if data.working_anim then
    result.working_visualisations = {
      {
        constant_speed = true,
        animation = data.working_anim,
      }
    }
  end

  return result;
end

function create_anim(data)
  return {
      filename = "__starcraft__/graphics/low/" .. data.filename,
      line_length = data.line_length or data.frame_count,
      size = data.size,
      frame_count = data.frame_count,
      frame_sequence = data.frame_sequence,
      animation_speed = data.animation_speed,
      flags = data.flags,
      draw_as_shadow = data.draw_as_shadow,
      draw_as_glow = data.draw_as_glow,
      draw_as_light = data.draw_as_light,
      apply_runtime_tint = data.apply_runtime_tint,
      blend_mode = data.blend_mode,

      hr_version = {
          filename = "__starcraft__/graphics/hd/" .. data.filename,
          line_length = data.hr_line_length or data.frame_count,
          size = data.hr_size,
          scale = 0.5,
          frame_count = data.frame_count,
          frame_sequence = data.frame_sequence,
          animation_speed = data.animation_speed,
          flags = data.flags,
          draw_as_shadow = data.draw_as_shadow,
          draw_as_glow = data.draw_as_glow,
          draw_as_light = data.draw_as_light,
          apply_runtime_tint = data.apply_runtime_tint,
          blend_mode = data.blend_mode
      }
  }
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
    animation_speed = data.animation_speed
  }

  return {
    layers = table.map(layers, function(layer)
      if layer == "main" then
        return create_anim(table.merge({
            filename = data.name .. "_diffuse.png"
          }, common_attributes))
      elseif layer == "teamcolor" then
        return create_anim(table.merge({
          filename = data.name .. "_teamcolor.png",
          apply_runtime_tint = true,
          --flags = { "mask" },
        }, common_attributes))
      elseif layer == "emissive" then
        return create_anim(table.merge({
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
  return result
end

function make_protoss_structure(data)
  local result = make_functional_structure(data)
  result.subgroup = "starcraft-protoss-buildings"

  -- TODO: Protoss shields

  result.flags = {
    "not-repairable",
    table.unpack(result.flags)
  }

  result.damaged_trigger_effect = {
    type = "script",
    effect_id = "on_protoss_bldg_dmg" -- Used to update overlays
  }
  return result
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
