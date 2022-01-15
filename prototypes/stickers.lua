local table = require('__stdlib__/stdlib/utils/table')
require("entity.helpers")

local function register_sticker(tbl)
  data:extend({table.dictionary_merge({
    type = "sticker",
    icon = "__base__/graphics/icons/info.png",
    icon_size = 64,
    single_particle = true,
    animation = tbl.animation or create_anim(tbl.anim)
  }, tbl)})
end

local name_extension = { "-sm", "-med", "-lg" }
local function def_size_sticker(tbl)
  for i = 1, 3 do
    register_sticker(table.dictionary_merge({
      name = tbl.name .. name_extension[i],
      anim = table.dictionary_merge(tbl.anims[i], tbl.anim_common)
    }, tbl))
  end
end

-- TODO: Define sticker render layer for ground vs air units

register_sticker{
  -- TODO: attack speed logic
  name = "starcraft-stimpack",
  duration_in_ticks = 746,
  target_movement_modifier = 1.5,
  vehicle_speed_modifier = 1.5,
  animation = {
    filename = "__starcraft__/graphics2/blank.png",
    frame_count = 1,
    size = {1, 1}
  }
}

def_size_sticker{
  -- TODO: disable parent entity while sticker attached
  -- TODO: init animation: { 1, 2, 3, 4, 5, 6, 7 }
  --    Could do blank frames at the start instead of having to track and lua-reappear the sticker.
  --    Use simple-smoke for timed anim.
  -- TODO: end animation: { 14 }
  --    Add a timed anim/picture w/ target when the sticker dies
  name = "starcraft-lockdown",
  duration_in_ticks = 2641,
  target_movement_modifier = 0,
  vehicle_speed_modifier = 0,
  anim_common = {
    frame_count = 14,
    frame_sequence = { 8, 9, 10, 11, 12, 13, 12, 11, 10, 9, 8 },
    animation_speed = 1/5 -- 84 ms per frame
  },
  anims = {
    {
      filename = "main_361_diffuse.png",
      hr_size = { 287, 286 },
      size = { 144, 143 }
    },
    {
      filename = "main_362_diffuse.png",
      hr_size = { 399, 428 },
      hr_line_length = 10,
      size = { 200, 214 }
    },
    {
      filename = "main_363_diffuse.png",
      hr_size = { 516, 532 },
      hr_line_length = 7,
      size = { 258, 266 }
    }
  }
}

def_size_sticker{
  -- Extra logic to disable this
  name = "starcraft-maelstrom",
  duration_in_ticks = 444,
  target_movement_modifier = 0,
  vehicle_speed_modifier = 0,
  anim_common = {
    frame_count = 25,
    animation_speed = 1/5 -- 84 ms per frame
  },
  anims = {
    {
      filename = "main_982_diffuse.png",
      hr_size = { 118, 123 },
      size = { 59, 62 }
    },
    {
      filename = "main_983_diffuse.png",
      hr_size = { 238, 241 },
      hr_line_length = 17,
      size = { 119, 120 }
    },
    {
      filename = "main_984_diffuse.png",
      hr_size = { 470, 484 },
      hr_line_length = 8,
      size = { 235, 242 },
      line_length = 17
    }
  }
}

local stasis_anim_sm = {
  filename = "main_365_diffuse.png",
  hr_size = { 273, 236 },
  size = { 137, 119 }
}

def_size_sticker{
  -- TODO: Extra logic to disable and make invincible
  -- TODO: init animation after random: { 1 } waitrand(3, 8) { 2, 3, 4, 5, 6, 7 }
  -- TODO: death anim: { 7, 6, 5, 4, 3, 2, 1 }
  name = "starcraft-stasis",
  duration_in_ticks = 2641,
  target_movement_modifier = 0,
  vehicle_speed_modifier = 0,
  anim_common = {
    frame_count = 13,
    -- NOTE: there's a waitrand(1,3), replacing it with a repeat final frame for simplicity
    frame_sequence = { 8, 9, 10, 11, 12, 13, 13 },
    animation_speed = 1/5 -- 84 ms per frame
  },
  anims = {
    stasis_anim_sm,
    stasis_anim_sm,
    {
      filename = "main_367_diffuse.png",
      hr_size = { 375, 377 },
      hr_line_length = 10,
      size = { 188, 189 }
    }
  }
}

-- TODO: matrix has both an overlay and underlay associated with it, may not do a sticker or maybe do 2 stickers
--def_sticker{
--  -- Extra logic for damage tracking and overlays
--  name = "starcraft-matrix",
--  duration_in_ticks = 3387
--}

register_sticker{
  -- TODO: Irradiate logic
  name = "starcraft-irradiate",
  duration_in_ticks = 1512,
  --damage_interval = 2,
  --damage_per_tick = {
  --  amount = (249.0 / 25.2) * 2.0 / 60,  -- TODO: find actual value
  --  type = "poison"
  --},
  anim = {
    filename = "main_380_diffuse.png",
    frame_count = 6,
    animation_speed = 1/5, -- 84 ms per frame
    size = { 262, 251 },
    hr_size = { 524, 504 }
  }
}

def_size_sticker{
  -- TODO: Custom damage per tick logic
  name = "starcraft-plague",
  duration_in_ticks = 1512,
  --damage_interval = 2,
  --damage_per_tick = (249.0 / 25.2) * 2.0 / 60,
  -- TODO: find actual value, also this should not impact shields
  -- Use special damage type and capture it in a filter, skip shields and prevent death
  -- https://wiki.factorio.com/Prototype/DamageType
  anim_common = {
    frame_count = 4,
    -- NOTE: Creation has waitrand(1, 3) 
    -- NOTE: Last frame is waitrand(2,3), skipping to favour of simplicity
    animation_speed = 1/5 -- 84 ms per frame
  },
  anims = {
    {
      filename = "main_388_diffuse.png",
      hr_size = { 76, 85 },
      size = { 38, 43 }
    },
    {
      filename = "main_389_diffuse.png",
      hr_size = { 130, 110 },
      size = { 65, 55 }
    },
    {
      filename = "main_390_diffuse.png",
      hr_size = { 220, 182 },
      size = { 110, 92 }
    }
  }
}

def_size_sticker{
  name = "starcraft-ensnare",
  duration_in_ticks = 1512,
  target_movement_modifier = 0.5,
  vehicle_speed_modifier = 0.5,
  anim_common = {
    frame_count = 4,
    -- NOTE: Creation has waitrand(1, 3) 
    -- NOTE: Last frame is waitrand(2,3), skipping to favour of simplicity
    animation_speed = 1/5 -- 84 ms per frame
  },
  anims = {
    {
      filename = "main_384_diffuse.png",
      hr_size = { 80, 94 },
      size = { 41, 47 }
    },
    {
      filename = "main_385_diffuse.png",
      hr_size = { 134, 117 },
      size = { 67, 58 }
    },
    {
      filename = "main_386_diffuse.png",
      hr_size = { 220, 182 },
      size = { 110, 92 }
    }
  }
}

--def_sticker{
--  -- Extra logic to take more damage and slow attacks
--  name = "starcraft-acid-spore",
--  duration_in_ticks = 3024
--}
--
--def_sticker{
--  -- Extra logic to take more damage and slow attacks
--  name = "starcraft-acid-spore-gfx-1",
--  duration_in_ticks = 3024
--}
--
--def_sticker{
--  -- Extra logic to take more damage and slow attacks
--  name = "starcraft-acid-spore-gfx-2",
--  duration_in_ticks = 3024
--}
--
--def_sticker{
--  -- Extra logic to take more damage and slow attacks
--  name = "starcraft-acid-spore-gfx-3",
--  duration_in_ticks = 3024
--}
--
--def_sticker{
--  -- Extra logic to take more damage and slow attacks
--  name = "starcraft-acid-spore-gfx-4",
--  duration_in_ticks = 3024
--}
