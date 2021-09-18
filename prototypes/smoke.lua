require("prototypes.entity.helpers")

-- time_between_frames is in Starcraft ticks
local function make_simple_smoke(table)
  --anim_speed = (1000/(42 * (table.time_between_frames or 1)))/60  -- ((1000ms/s / 42ms/frame) / 60t/s)/2
  local num_ticks_per_frame = math.ceil(60/(1000/(42 * (table.time_between_frames or 1))))

  local frame_sequence = {}
  for frame = 1, table.frame_count do
    for i = 1, num_ticks_per_frame do
      frame_sequence[#frame_sequence + 1] = frame
    end
  end

  return {
    type = "trivial-smoke",
    name = table.name,
    animation = {
      -- TODO: HD/SD difference
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

local function make_simple_smoke_anim(data)
  return {
    type = "trivial-smoke",
    name = data.name,
    animation = create_anim(data.anim),
    duration = data.duration,
    affected_by_wind = false,
    show_when_smoke_off = true,
    movement_slow_down_factor = 0,
    color = {1, 1, 1, 0.9}
  }
end

local function make_shield_hit(index)
  local num_ticks_per_frame = math.ceil(60/(1000/42))

  -- TODO: refactor this part out of here
  local frame_sequence = {}
  for frame = 1, 4 do
    for i = 1, num_ticks_per_frame do
      frame_sequence[#frame_sequence + 1] = frame
    end
  end


  local hr_filename = index <= 27 and "main_424_diffuse_1.png" or "main_424_diffuse_2.png"

  local anim_data = {
    hr_filename = hr_filename,
    low_filename = "main_424_diffuse.png",
    size = { 114, 147 },
    hr_size = { 229, 294 },
    frame_count = 4,
    line_length = 4,
    draw_as_glow = true,
    frame_sequence = frame_sequence,
    y = 147 * ((index - 1) % 27),
    hr_y = 294 * ((index - 1) % 27)
  }

  return make_simple_smoke_anim({
    name = "starcraft-shield-hit-" .. tostring(index),
    anim = anim_data,
    duration = num_ticks_per_frame * 4,
  })
end

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
  make_simple_smoke_anim{
    name = "starcraft-dragbull_explode",
    anim = {
      filename = "main_427_diffuse.png",
      size = { 118, 121 },
      hr_size = { 237, 243 },
      frame_count = 14,
      draw_as_glow = true,
      animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
    },
    duration = 2.52 * 14
  }
})

-- Shield hit overlays
for i = 1, 32 do
  data:extend({
    make_shield_hit(i)
  })
end
