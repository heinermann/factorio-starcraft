
blank_anim = {
  direction_count = 18,
  size = {1, 1},
  filename = "__starcraft__/graphics2/blank.png"
}

data:extend({
  {
    -- PrototypeBase
    name = "starcraft-actor",
    type = "character",

    -----------------------
    -- Entity
    -----------------------
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    allow_copy_paste = false,
    build_sound = nil,
    collision_mask = {},
    created_smoke = {
      smoke_name = "starcraft-smokeless"
    },
    flags = {
      "not-rotatable",
      "placeable-off-grid",
      "not-repairable",
      "not-blueprintable",
      "not-deconstructable",
      "hidden",
      "not-flammable",
      "no-automated-item-removal",
      "no-automated-item-insertion",
      "no-copy-paste",
      "not-selectable-in-game",
      "not-upgradable",
      "not-in-kill-statistics"
    },
    selectable_in_game = false,
    subgroup = "starcraft-terran-ground-units",

    -----------------------
    -- EntityWithHealth
    -----------------------
    alert_when_damaged = false,
    healing_per_tick = 0,
    max_health = 1000,

    -----------------------
    -- Character
    -----------------------
    mining_speed = 0,
    running_speed = 0,
    distance_per_frame = 0,
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
        idle = blank_anim,
        idle_with_gun = blank_anim,
        mining_with_tool = blank_anim,
        running_with_gun = blank_anim,
        running = blank_anim
      }
    },
    tool_attack_distance = 0,
    has_belt_immunity = true,
    crafting_categories = {"starcraft-none"},
    mining_categories = {"starcraft-none"}
  }
})
