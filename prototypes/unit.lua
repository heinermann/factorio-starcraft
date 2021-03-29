data:extend({
  {
    -- PrototypeBase
    name = "test-unit",
    type = "unit",

    -----------------------
    -- Unit
    -----------------------
    run_animation = {
      direction_count = 1,
      size = {64, 64},
      filename = "__starcraft__/graphics/blank.png"
    },
    attack_parameters = {
      type = "projectile",
      range = 1,
      cooldown = 1,
      -- min_range
      -- turn_range
      -- 
      range_mode = "bounding-box-to-bounding-box",
      -- min_attack_distance
      -- damage_modifier
      ammo_consumption_modifier = 0,
      -- cooldown_deviation
      -- warmup
      -- movement_slow_down_cooldown
      -- movement_slow_down_factor
      -- sound
      -- cyclic_sound
      -- use_shooter_direction
      animation = {
        direction_count = 1,
        size = {64, 64},
        filename = "__starcraft__/graphics/blank.png"
      },
      ammo_type = {
        category = "melee"
      }
    },
    movement_speed = 0,
    distance_per_frame = 0,
    pollution_to_join_attack = 0,
    distraction_cooldown = 0,
    vision_distance = 1,      -- target acquision?
    rotation_speed = 0,
    min_pursue_time = 0,
    has_belt_immunity = false,
    max_pursue_distance = 50,
    radar_range = 12,   -- vision?
    ai_settings = {
      do_separation = false
    },
    move_while_shooting = false,
    can_open_gates = false,
    affected_by_tiles = true,
    render_layer = "object",
    -- alternative_attacking_frame_sequence
    --    warmup_frame_sequence  - AttackInit
    --    attacking_frame_sequence - AttackRepeat
    --    back_to_walk_frame_sequence - AttackToIdle

    -----------------------
    -- EntityWithHealth
    -----------------------
    alert_when_damaged = true,
    --attack_reaction = 
    --corpse  -- death remnants
    damaged_trigger_effect = {
      type = "script",
      effect_id = "starcraft_damaged"
      -- damage_type_filters (anything special?)
    },
    -- dying_explosion    -- new entity with offset
    dying_trigger_effect = {
      type = "script",
      effect_id = "starcraft_dying"
      -- damage_type_filters (anything special?)
    },
    healing_per_tick = 0, -- zerg regen
    hide_resistances = false,
    max_health = 100,
    -- random_corpse_variation = 
    -- repair_speed_modifier = 
    resistances = {
      { type = "physical", percent = 0 },
      { type = "impact", percent = 0 },
      { type = "explosion", percent = 0 },
      { type = "fire", percent = 0 },
      { type = "laser", percent = 0 },
      { type = "acid", percent = 0 },
      { type = "electric", percent = 0 },
      { type = "poison", percent = 0 },
      { type = "psionic", percent = 0 } -- new type for feedback, psi storm
    },

    -----------------------
    -- Entity
    -----------------------
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    allow_copy_paste = false,
    build_sound = nil,
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    collision_mask = {"player-layer", "train-layer", "not-colliding-with-itself"},
    -- created_effect = 
    -- created_smoke
    -- drawing_box
    -- enemy_map_color
    flags = {
      "not-rotatable",
      "placeable-enemy",
      "placeable-off-grid",
      "breaths-air",
      "not-blueprintable",
      "not-deconstructable",
      "not-flammable",
      "no-automated-item-removal",
      "no-automated-item-insertion",
      "no-copy-paste",
      "not-upgradable"
    },
    -- friendly_map_color
    -- hit_visualization_box  (in case beams look weird)
    -- map_color
    -- map_generator_bounding_box = 
    -- minable
    -- radius_visualisation_specification   -- selection circle
    selectable_in_game = true,
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    -- selection_priority  -- prioritize air units and non-structures first
    -- sticker_box -- in case it doesn't align correctly
    subgroup = "terran"
    -- tile_width = 8,
    -- tile_height = 8,
    -- trigger_target_mask = {}  -- things that this can target?
    -- water_reflection
    -- working_sound
  }
})
