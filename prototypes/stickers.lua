data:extend({
  {
    type = "sticker",
    name = "starcraft-stimpack",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 756, -- TODO: find actual value
    target_movement_modifier = 1.5, -- TODO: find actual value
    single_particle = true
  },
  {
    -- Extra logic to disable this
    type = "sticker",
    name = "starcraft-lockdown",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 2646, -- TODO: find actual value
    target_movement_modifier = 0,
    vehicle_speed_modifier = 0,
    single_particle = true
  },
  {
    -- Extra logic for damage reduction
    type = "sticker",
    name = "starcraft-matrix",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3402, -- TODO: find actual value
    single_particle = true
  },
  {
    type = "sticker",
    name = "starcraft-irradiate",   -- TODO: This needs to be something else because it should deal AOE poison damage
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 1512, -- TODO: find actual value
    --damage_interval = 2,
    --damage_per_tick = (249.0 / 25.2) * 2.0 / 60,  -- TODO: find actual value
    single_particle = true
  },
  {
    type = "sticker",
    name = "starcraft-plague",    -- TODO: Ensure this doesn't kill the EntityWithHealth
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 1512, -- TODO: find actual value
    --damage_interval = 2,
    --damage_per_tick = (249.0 / 25.2) * 2.0 / 60,  -- TODO: find actual value, also this should not impact shields
    single_particle = true
  },
  {
    type = "sticker",
    name = "starcraft-ensnare",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 1512, -- TODO: find actual value
    target_movement_modifier = 0.5,
    vehicle_speed_modifier = 0.5,
    single_particle = true
  },
  {
    -- Extra logic to disable and make invincible
    type = "sticker",
    name = "starcraft-stasis",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 2646, -- TODO: find actual value
    target_movement_modifier = 0,
    vehicle_speed_modifier = 0,
    single_particle = true
  },
  {
    -- Extra logic to take more damage and slow attacks
    type = "sticker",
    name = "starcraft-acid-spore",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3024, -- TODO: find actual value
    single_particle = true
  },
  {
    -- Extra logic to take more damage and slow attacks
    type = "sticker",
    name = "starcraft-acid-spore-gfx-1",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3024, -- TODO: find actual value
    single_particle = true
  },
  {
    -- Extra logic to take more damage and slow attacks
    type = "sticker",
    name = "starcraft-acid-spore-gfx-2",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3024, -- TODO: find actual value
    single_particle = true
  },
  {
    -- Extra logic to take more damage and slow attacks
    type = "sticker",
    name = "starcraft-acid-spore-gfx-3",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3024, -- TODO: find actual value
    single_particle = true
  },
  {
    -- Extra logic to take more damage and slow attacks
    type = "sticker",
    name = "starcraft-acid-spore-gfx-4",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    duration_in_ticks = 3024, -- TODO: find actual value
    single_particle = true
  }
})
