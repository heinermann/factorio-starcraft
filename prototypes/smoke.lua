require("prototypes.entity.helpers")

local function make_simple_smoke_anim(data)
  data.anim.frame_time = data.anim.frame_time or 1

  local total_duration = 0
  local anim_seq = data.anim.frame_sequence
  if anim_seq ~= nil then
    data.anim.frame_sequence = {}
    total_duration = math.floor(data.anim.frame_time * #anim_seq)
    local frame = 1
    for i = 1, total_duration do
      if i >= frame * data.anim.frame_time then
        frame = frame + 1
      end
      table.insert(data.anim.frame_sequence, anim_seq[frame])
    end

  else
    data.anim.frame_sequence = {}
    total_duration = math.floor(data.anim.frame_time * data.anim.frame_count)
    local frame = 1
    for i = 1, total_duration do
      if i >= frame * data.anim.frame_time then
        frame = frame + 1
      end
      table.insert(data.anim.frame_sequence, frame)
    end

  end

  return {
    type = "trivial-smoke",
    name = data.name,
    animation = create_anim(data.anim),
    duration = data.duration or total_duration,
    affected_by_wind = false,
    show_when_smoke_off = true,
    movement_slow_down_factor = 0,
    color = {1, 1, 1, data.alpha or 1},
    render_layer = data.render_layer or "smoke"
  }
end

local function make_shield_hit(index, type)
  local hr_filename = index <= 27 and "main_424_diffuse_1.png" or "main_424_diffuse_2.png"

  local anim_data = {
    hr_filename = hr_filename,
    low_filename = "main_424_diffuse.png",
    size = { 114, 147 },
    hr_size = { 229, 294 },
    frame_count = 4,
    line_length = 4,
    draw_as_glow = true,
    y = 147 * ((index - 1) % 27),
    hr_y = 294 * ((index - 1) % 27),
    frame_time = 2.52,
  }

  local layer = "smoke"
  if type == "ground" then
    layer = "wires-above" -- 136
  elseif type == "air" then
    layer = "light-effect" -- 148 (using 147 for some air units)
  end

  return make_simple_smoke_anim({
    name = "starcraft-shield-hit-" .. tostring(index) .. "-" .. type,
    anim = anim_data,
    render_layer = layer,
  })
end

data:extend({
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-1",
    anim = {
      filename = "main_430_diffuse.png",
      size = { 87, 182 },
      hr_size = { 174, 367 },
      frame_count = 8,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-2",
    anim = {
      filename = "main_431_diffuse.png",
      size = { 86, 156 },
      hr_size = { 172, 310 },
      frame_count = 8,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-3",
    anim = {
      filename = "main_432_diffuse.png",
      size = { 60, 89 },
      hr_size = { 118, 177 },
      frame_count = 8,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-4",
    anim = {
      filename = "main_433_diffuse.png",
      size = { 76, 154 },
      hr_size = { 152, 308 },
      frame_count = 8,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-5",
    anim = {
      filename = "main_434_diffuse.png",
      size = { 65, 102 },
      hr_size = { 128, 202 },
      frame_count = 8,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-vespene-smoke-depleted",
    anim = {
      filename = "main_435_diffuse.png",
      size = { 28, 46 },
      hr_size = { 56, 90 },
      frame_count = 5,
      draw_as_glow = true,
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-dragbull_explode",
    anim = {
      filename = "main_427_diffuse.png",
      size = { 118, 121 },
      hr_size = { 237, 243 },
      frame_count = 14,
      draw_as_glow = true,
      frame_time = 2.52
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-warp-anchor-flash",
    anim = {
      filename = "main_211_diffuse.png",
      frame_count = 14,
      line_length = 13,
      size = { 298, 300 },
      hr_line_length = 6,
      hr_size = { 596, 599 },
      draw_as_glow = true,
      frame_sequence = { 1, 2 },
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-burrow-dust",
    anim = {
      filename = "main_423_diffuse.png",
      frame_count = 7,
      size = { 104, 56 },
      hr_size = { 209, 112 },
      frame_time = 5.04
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-landing-dust1",
    anim = {
      filename = "main_494_diffuse.png",
      frame_count = 10,
      size = { 61, 48 },
      hr_size = { 122, 97 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-landing-dust2",
    anim = {
      filename = "main_495_diffuse.png",
      frame_count = 8,
      size = { 77, 97 },
      hr_size = { 156, 194 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-landing-dust3",
    anim = {
      filename = "main_496_diffuse.png",
      frame_count = 10,
      size = { 61, 44 },
      hr_size = { 124, 87 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-landing-dust4",
    anim = {
      filename = "main_497_diffuse.png",
      frame_count = 8,
      size = { 106, 102 },
      hr_size = { 213, 204 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-landing-dust5",
    anim = {
      filename = "main_498_diffuse.png",
      frame_count = 8,
      size = { 106, 99 },
      hr_size = { 211, 197 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-liftoff-dust1",
    anim = {
      filename = "main_499_diffuse.png",
      frame_count = 10,
      size = { 58, 87 },
      hr_size = { 116, 174 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-liftoff-dust2",
    anim = {
      filename = "main_500_diffuse.png",
      frame_count = 10,
      size = { 51, 76 },
      hr_size = { 103, 154 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-liftoff-dust3",
    anim = {
      filename = "main_501_diffuse.png",
      frame_count = 10,
      size = { 62, 78 },
      hr_size = { 122, 155 },
      frame_time = 7.56
    }
  },
  make_simple_smoke_anim{
    name = "starcraft-liftoff-dust4",
    anim = {
      filename = "main_502_diffuse.png",
      frame_count = 10,
      size = { 76, 80 },
      hr_size = { 152, 159 },
      frame_time = 7.56
    }
  },
  {
    type = "trivial-smoke",
    name = "starcraft-smokeless",
    duration = 1,
    cyclic = true,
    animation = {
      filename = "__starcraft__/graphics2/blank.png",
      frame_count = 1,
      size = {1, 1}
    }
  }
})

-- Shield hit overlays
for i = 1, 32 do
  data:extend({
    make_shield_hit(i, "ground"),
    make_shield_hit(i, "air"),
  })
end
