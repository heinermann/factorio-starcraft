
blank_anim = {
  direction_count = 18,
  size = {1, 1},
  filename = "__starcraft__/graphics/blank.png"
}

anim_221_idle = {
  layers = {
    {
      filename = "__starcraft__/graphics/main_221_diffuse.png",
      size = { 78, 124 },
      line_length = 8,
      frame_count = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      direction_count = 34,
      animation_speed = 1 / 2.52   -- Starcraft fastest speed @ 23.8 fps
    },
    {
      filename = "__starcraft__/graphics/main_221_teamcolor.png",
      size = { 78, 124 },
      line_length = 8,
      frame_count = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      apply_runtime_tint = true,
      direction_count = 34,
      animation_speed = 1 / 2.52
    },
    {
      -- TODO: Move to script, for cloaking
      filename = "__starcraft__/graphics/main_222_diffuse.png",
      size = { 80, 54 },
      line_length = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      draw_as_shadow = true,
      frame_count = 8,
      direction_count = 34,
      animation_speed = 1 / 2.52
    }
  }
}

anim_221_run = {
  layers = {
    {
      filename = "__starcraft__/graphics/main_221_diffuse.png",
      size = { 78, 124 },
      line_length = 8,
      frame_count = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      direction_count = 34,
      animation_speed = 1 / 2.52
    },
    {
      filename = "__starcraft__/graphics/main_221_teamcolor.png",
      size = { 78, 124 },
      line_length = 8,
      frame_count = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      apply_runtime_tint = true,
      direction_count = 34,
      animation_speed = 1 / 2.52
    },
    {
      -- TODO: Move to script, for cloaking
      filename = "__starcraft__/graphics/main_222_diffuse.png",
      size = { 80, 54 },
      line_length = 8,
      scale = 0.5,
      shift = {0, -9.0/16},
      draw_as_shadow = true,
      frame_count = 8,
      direction_count = 34,
      animation_speed = 1 / 2.52
    }
  }
}

data:extend({
  {
    -- PrototypeBase
    name = "test-unit",
    type = "car",

    -----------------------
    -- Unit
    -----------------------
    --run_animation = blank_anim,
    --attack_parameters = {
    --  type = "projectile",
    --  range = 1,
    --  cooldown = 1,
    --  -- min_range
    --  -- turn_range
    --  -- 
    --  range_mode = "bounding-box-to-bounding-box",
    --  -- min_attack_distance
    --  -- damage_modifier
    --  ammo_consumption_modifier = 0,
    --  -- cooldown_deviation
    --  -- warmup
    --  -- movement_slow_down_cooldown
    --  -- movement_slow_down_factor
    --  -- sound
    --  -- cyclic_sound
    --  -- use_shooter_direction
    --  animation = blank_anim,
    --  ammo_type = {
    --    category = "melee"
    --  }
    --},
    --movement_speed = 0,
    --distance_per_frame = 0,
    --pollution_to_join_attack = 0,
    --distraction_cooldown = 0,
    --vision_distance = 1,      -- target acquision?
    --rotation_speed = 0,
    --min_pursue_time = 0,
    --has_belt_immunity = false,
    --max_pursue_distance = 50,
    --radar_range = 12,   -- vision?
    --ai_settings = {
    --  do_separation = false
    --},
    --move_while_shooting = false,
    --can_open_gates = false,
    --affected_by_tiles = true,
    --render_layer = "object",
    ---- alternative_attacking_frame_sequence
    ----    warmup_frame_sequence  - AttackInit
    ----    attacking_frame_sequence - AttackRepeat
    ----    back_to_walk_frame_sequence - AttackToIdle

    -----------------------
    -- Car
    -----------------------
    animation = blank_anim,
    effectivity = 0,
    consumption = "0W",
    rotation_speed = 1,
    energy_source = {
      type = "void",
      render_no_power_icon = false,
      render_no_network_icon = false
    },
    inventory_size = 0,
    render_layer = "object",
    has_belt_immunity = false,
    immune_to_tree_impacts = true,
    immune_to_rock_impacts = true,
    -- guns =  -- TODO

    -----------------------
    -- Vehicle
    -----------------------
    weight = 1,
    braking_force = 1,
    friction_force = 1,
    energy_per_hit_point = 0,
    terrain_friction_modifier = 1,
    -- crash_trigger
    -- stop_trigger
    equipment_grid = "starcraft-unit-eg",
    allow_passengers = false,
    
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
    subgroup = "starcraft-terran-ground-units",
    -- tile_width = 8,
    -- tile_height = 8,
    -- trigger_target_mask = {}  -- things that this can target?
    -- water_reflection
    -- working_sound
  },
  {
    -- PrototypeBase
    name = "starcraft-unit-base",
    type = "character",

    -----------------------
    -- Entity
    -----------------------
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    allow_copy_paste = false,
    build_sound = nil,
    collision_box = {{-8.0/16, -9.0/16}, {9.0/16, 11.0/16}},
    collision_mask = {"player-layer", "train-layer", "not-colliding-with-itself"},
    -- created_effect = 
    -- created_smoke
    -- drawing_box
    -- enemy_map_color
    flags = {
      "placeable-neutral",
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
    selection_box = {{-8.0/16, -9.0/16}, {8.0/16, 10.0/16}},
    -- selection_priority  -- prioritize air units and non-structures first
    -- sticker_box -- in case it doesn't align correctly
    subgroup = "starcraft-terran-ground-units",
    -- tile_width = 8,
    -- tile_height = 8,
    -- trigger_target_mask = {}  -- things that this can target?
    -- water_reflection
    -- working_sound

    -----------------------
    -- EntityWithHealth
    -----------------------
    alert_when_damaged = false,
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
    -- Character
    -----------------------
    mining_speed = 0,
    running_speed = 0.1,
    distance_per_frame = 0.1,
    maximum_corner_sliding_distance = 0,
    heartbeat = table.deepcopy(data.raw["character"]["character"].heartbeat),
    eat = table.deepcopy(data.raw["character"]["character"].eat),
    inventory_size = 0,
    build_distance = 0,
    drop_item_distance = 0,
    reach_distance = 0,
    reach_resource_distance = 0,
    item_pickup_distance = 0,
    loot_pickup_distance = 0,
    ticks_to_keep_gun = 0,
    ticks_to_keep_aiming_direction = 0,
    ticks_to_stay_in_combat = 0,
    damage_hit_tint = {},
    running_sound_animation_positions = {},
    mining_with_tool_particles_animation_positions = {},
    animations = {
      {
        idle = anim_221_idle,
        idle_with_gun = blank_anim,
        mining_with_tool = blank_anim,
        running_with_gun = blank_anim,
        flipped_shadow_running_with_gun = nil,
        running = anim_221_run
      }
    },
    tool_attack_distance = 0,
    has_belt_immunity = false,
    --character_corpse = "character-corpse"
    crafting_categories = {"starcraft-none"},
    mining_categories = {"starcraft-none"}
  }
})
