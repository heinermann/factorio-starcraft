local function make_simple_anim(table)
  --anim_speed = (1000/(42 * (table.time_between_frames or 1)))/60  -- ((1000ms/s / 42ms/frame) / 60t/s)/2
  num_ticks_per_frame = math.ceil(60/(1000/(42 * (table.time_between_frames or 1))))

  frame_sequence = {}
  for frame = 1, table.frame_count do
    for i = 1, num_ticks_per_frame do
      frame_sequence[#frame_sequence + 1] = frame
    end
  end

  return {
    type = "animation",
    name = table.name,
    filename = table.filename,
    size = table.size,
    scale = 0.5,
    draw_as_glow = table.draw_as_glow or false,
    frame_count = table.frame_count,
    line_length = table.line_length or table.frame_count,
    frame_sequence = frame_sequence,
    max_advance = 0
    --animation_speed = anim_speed
  }
end

-- time_between_frames is in Starcraft ticks

data:extend({
  {
    type = "sprite",
    name = "starcraft-vespene-geyser-shadow",
    filename = "__starcraft__/graphics/main_346_diffuse.png",
    size = { 392, 166 },
    scale = 0.5,
    flags = {"shadow"},
    draw_as_shadow = true
  },

  make_simple_anim{
    name = "starcraft-vespene-smoke-1",
    filename = "__starcraft__/graphics/main_430_diffuse.png",
    size = { 166, 264 },
    shift = {-58/16, -103/16},
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_anim{
    name = "starcraft-vespene-smoke-2",
    filename = "__starcraft__/graphics/main_431_diffuse.png",
    size = { 160, 316 },
    shift = {-22/16, 0/16},
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_anim{
    name = "starcraft-vespene-smoke-3",
    filename = "__starcraft__/graphics/main_432_diffuse.png",
    size = { 124, 347 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_anim{
    name = "starcraft-vespene-smoke-4",
    filename = "__starcraft__/graphics/main_433_diffuse.png",
    size = { 352, 512 },
    frame_count = 8,
    line_length = 5,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_anim{
    name = "starcraft-vespene-smoke-5",
    filename = "__starcraft__/graphics/main_434_diffuse.png",
    size = { 218, 472 },
    frame_count = 8,
    time_between_frames = 2,
    draw_as_glow = true
  },
  make_simple_anim{
    name = "starcraft-vespene-smoke-depleted",
    filename = "__starcraft__/graphics/main_435_diffuse.png",
    size = { 204, 320 },
    frame_count = 5,
    time_between_frames = 2,
    draw_as_glow = true
  },
})
