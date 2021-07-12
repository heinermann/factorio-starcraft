local function def_sticker(tbl)
  return {
    type = "sticker",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    single_particle = true,
    table.unpack(tbl)
  }  
end

data:extend({
  def_sticker{
    name = "starcraft-stimpack",
    duration_in_ticks = 746,
    target_movement_modifier = 1.5
  },
  def_sticker{
    -- Extra logic to disable this
    name = "starcraft-lockdown",
    duration_in_ticks = 2641,
    target_movement_modifier = 0,
    vehicle_speed_modifier = 0
  },
  def_sticker{
    -- Extra logic to disable this
    name = "starcraft-maelstrom",
    duration_in_ticks = 444,
    target_movement_modifier = 0,
    vehicle_speed_modifier = 0
  },
  def_sticker{
    -- Extra logic to disable and make invincible
    name = "starcraft-stasis",
    duration_in_ticks = 2641,
    target_movement_modifier = 0,
    vehicle_speed_modifier = 0
  },
  def_sticker{
    -- Extra logic for damage reduction
    name = "starcraft-matrix",
    duration_in_ticks = 3387
  },
  def_sticker{
    name = "starcraft-irradiate",
    duration_in_ticks = 1512
    --damage_interval = 2,
    --damage_per_tick = (249.0 / 25.2) * 2.0 / 60,  -- TODO: find actual value
  },
  def_sticker{
    name = "starcraft-plague",    -- TODO: Ensure this doesn't kill the EntityWithHealth
    duration_in_ticks = 1512,
    --damage_interval = 2,
    --damage_per_tick = (249.0 / 25.2) * 2.0 / 60,  -- TODO: find actual value, also this should not impact shields
  },
  def_sticker{
    name = "starcraft-ensnare",
    duration_in_ticks = 1512,
    target_movement_modifier = 0.5,
    vehicle_speed_modifier = 0.5
  },
  def_sticker{
    -- Extra logic to take more damage and slow attacks
    name = "starcraft-acid-spore",
    duration_in_ticks = 3024
  },
  def_sticker{
    -- Extra logic to take more damage and slow attacks
    name = "starcraft-acid-spore-gfx-1",
    duration_in_ticks = 3024
  },
  def_sticker{
    -- Extra logic to take more damage and slow attacks
    name = "starcraft-acid-spore-gfx-2",
    duration_in_ticks = 3024
  },
  def_sticker{
    -- Extra logic to take more damage and slow attacks
    name = "starcraft-acid-spore-gfx-3",
    duration_in_ticks = 3024
  },
  def_sticker{
    -- Extra logic to take more damage and slow attacks
    name = "starcraft-acid-spore-gfx-4",
    duration_in_ticks = 3024
  }
})
