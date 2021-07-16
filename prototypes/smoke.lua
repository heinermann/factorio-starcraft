local function make_simple_smoke(table)
  --anim_speed = (1000/(42 * (table.time_between_frames or 1)))/60  -- ((1000ms/s / 42ms/frame) / 60t/s)/2
  num_ticks_per_frame = math.ceil(60/(1000/(42 * (table.time_between_frames or 1))))

  frame_sequence = {}
  for frame = 1, table.frame_count do
    for i = 1, num_ticks_per_frame do
      frame_sequence[#frame_sequence + 1] = frame
    end
  end

  return {
    type = "trivial-smoke",
    name = table.name,
    animation = {
      filename = table.filename,
      size = table.size,
      scale = 0.5,
      draw_as_glow = table.draw_as_glow or false,
      frame_count = table.frame_count,
      line_length = table.line_length or table.frame_count,
      frame_sequence = frame_sequence,
      shift = table.shift,
      --animation_speed = animation_speed-- This is broken.
      -- If Factorio doesn't get an animation in something that doesn't easily divide 60 ticks per second it throws a fit.
    },
    duration = num_ticks_per_frame * table.frame_count,
    movement_slow_down_factor = 0,
    fade_away_duration = 6,
    affected_by_wind = false,
    show_when_smoke_off = true,
    color = {1, 1, 1, 0.9},
  }
end

-- time_between_frames is in Starcraft ticks

data:extend({
  make_simple_smoke{
    name = "starcraft-vespene-smoke-1",
    filename = "__starcraft__/graphics/hd/main_430_diffuse.png",
    size = { 174, 367 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_smoke{
    name = "starcraft-vespene-smoke-2",
    filename = "__starcraft__/graphics/hd/main_431_diffuse.png",
    size = { 172, 310 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_smoke{
    name = "starcraft-vespene-smoke-3",
    filename = "__starcraft__/graphics/hd/main_432_diffuse.png",
    size = { 118, 177 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_smoke{
    name = "starcraft-vespene-smoke-4",
    filename = "__starcraft__/graphics/hd/main_433_diffuse.png",
    size = { 152, 308 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_smoke{
    name = "starcraft-vespene-smoke-5",
    filename = "__starcraft__/graphics/hd/main_434_diffuse.png",
    size = { 128, 202 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_smoke{
    name = "starcraft-vespene-smoke-depleted",
    filename = "__starcraft__/graphics/hd/main_435_diffuse.png",
    size = { 56, 90 },
    frame_count = 5,
    time_between_frames = 2,
    draw_as_glow = true
  },
})
