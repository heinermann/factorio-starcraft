require("prototypes.entity.helpers")

local function make_gun(proto)
  local result = {
    type = "gun",
    name = proto.name,
    stack_size = 1,
    hidden = true,
    subgroup = "starcraft-weapons",
    attack_parameters = {
      type = "projectile",
      ammo_category = proto.ammo_category,
      projectile_center = proto.projectile_center,
      projectile_creation_distance = proto.projectile_creation_distance,
      projectile_creation_parameters = proto.projectile_creation_parameters,
      range = proto.range,
      cooldown = proto.cooldown,
      min_range = proto.min_range,
      turn_range = proto.turn_range,
      range_mode = "bounding-box-to-bounding-box",
      cooldown_deviation = 0.15,
      ammo_consumption_modifier = 0,
      warmup = proto.warmup,
      lead_target_for_projectile_speed = proto.lead_target_for_projectile_speed,
      ammo_type = proto.ammo_type, -- IMPORTANT
      sound = proto.sound,
      animation = proto.animation,
      use_shooter_direction = true,
    }
  }

  if proto.icon_id then
    result.icon = "__starcraft__/graphics/cmdicons/" .. tostring(proto.icon_id) .. ".png"
    result.icon_size = proto.icon_size or 128
  end

  return result
end

data:extend({
  {
    type = "ammo-category",
    name = "starcraft-protoss-air-weapons",
  },
})
data:extend({
  {
    type = "ammo",
    name = "starcraft-protoss-air-weapons-ammo",
    icon = "__starcraft__/graphics/cmdicons/358.png",
    icon_size = 128,
    stack_size = 1,
    flags = { "not-stackable" },
    subgroup = "starcraft-weapons",
    ammo_category = "starcraft-protoss-air-weapons",
    ammo_type = {
      consumption_modifier = 0,
    },
  },
})

data:extend({
  make_gun{
    name = "starcraft-wpn-dual-photon-blasters",
    icon_id = 358,
    range = 8, -- TODO: plus ? to fix the range discrepancy
    cooldown = sc_ticks_to_factorio_ticks(30 - 1),
    turn_range = 16 / 256.0,
    warmup = sc_ticks_to_factorio_ticks(1),
    ammo_category = "starcraft-protoss-air-weapons",
    ammo_type = {
      action = {
        type = "direct",
        action_delivery = {
          type = "instant", -- appear on target
          target_effects = {
            {
              type = "damage",
              damage = {
                amount = 8, -- +1 bonus
                type = "physical"
              }
            },
            {
              type = "create-trivial-smoke",
              smoke_name = "starcraft-blastgn-hit"
            },
            {
              type = "play-sound",
              play_on_target_position = true,
              sound = {
                filename = "__starcraft__/sound/bullet/blastgn2.wav",
                aggregation = {
                    max_count = 4,
                    remove = false,
                    count_already_playing = true
                }
              }
            }
          }
        }
      }
    }
  },
  --{
  --  type = "gun",
  --  name = "starcraft-wpn-anti-matter-missiles",
  --},
})
