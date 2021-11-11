local resource_autoplace = require("resource-autoplace");

data:extend({
  {
    type = "item",
    name = "starcraft-mineral-chunk",
    icon = "__starcraft__/graphics/hd/main_397_diffuse.png",
    icon_size = 74,
    stack_size = 64,
    flags = {"hidden"}
  },
  {
    type = "item",
    name = "starcraft-vespene-gas-orb",
    icon = "__starcraft__/graphics/hd/main_399_diffuse.png",
    icon_size = 78,
    stack_size = 64,
    flags = {"hidden"}
  },
  {
    type = "item",
    name = "starcraft-vespene-gas-sac",
    icon = "__starcraft__/graphics/hd/main_401_diffuse.png",
    icon_size = 78,
    stack_size = 64,
    flags = {"hidden"}
  },
  {
    type = "item",
    name = "starcraft-vespene-gas-tank",
    icon = "__starcraft__/graphics/hd/main_403_diffuse.png",
    icon_size = 72,
    stack_size = 64,
    flags = {"hidden"}
  },
  {
    type = "resource",
    name = "starcraft-mineral-field",
    category = "starcraft-minerals",
    icon = "__starcraft__/graphics/icons/0.png",
    icon_size = 56,
    flags = {"placeable-neutral"},
    collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile", "resource-layer"},
    collision_box = {{-32/16 + 0.001, -16/16 + 0.001}, {32/16 - 0.001, 16/16 - 0.001}},
    selection_box = {{-32/16, -16/16}, {32/16, 16/16}},

    stage_counts = {750, 500, 250, 0},
    stages = {
      sheet = {
        filename = "__starcraft__/graphics/hd/main_347_diffuse.png",
        priority = "extra-high",
        size = { 262, 253 },
        scale = 0.5,
        frame_count = 1,
        variation_count = 4
      }
    },
    stages_effect = {
      sheet = {
        filename = "__starcraft__/graphics/hd/main_347_emissive.png",
        priority = "medium",
        size = { 262, 253 },
        scale = 0.5,
        frame_count = 1,
        variation_count = 4,
        flags = {"light"},
        draw_as_light = true
      }
    },
    map_color = {0/256, 228/256, 252/256},
    map_grid = false,

    tree_removal_probability = 1,
    tree_removal_max_distance = 5,
    randomize_visual_position = false,

    tile_width = 4,
    tile_height = 2,
    --map_generator_bounding_box = {{-32/16, -16/16}, {31/16, 15/16}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "starcraft-resources",
      order = "e",
      base_density = 0.5,
      random_probability = 1/4,
      random_spot_size_minimum = 4,
      random_spot_size_maximum = 6,
      has_starting_area_placement = nil,
      regular_rq_factor_multiplier = 1,
      regular_blob_amplitude_multiplier = 2,
      seed1 = 1337,
      richness_post_multiplier = 0.4,
      minimum_richness = 1000,
      additional_richness = 400,
      candidate_spot_count = 64
    },

    minimum = 1,
    normal = 1500,
    minable = {
      mining_time = (75 * 42)/1000 /10,-- / 60, -- ((75 frames * 42ms/frame) / 1000ms/s) / 60ticks/s
      result = "starcraft-mineral-chunk",
      count = 8
    },
    remove_decoratives = "true",
    resource_patch_search_radius = 8
  },
  {
    type = "resource",
    name = "starcraft-vespene-geyser",
    category = "starcraft-vespene",
    icon = "__starcraft__/graphics/icons/2.png",
    icon_size = 56,
    flags = {"placeable-neutral"},
    collision_mask = {"item-layer", "object-layer", "player-layer", "water-tile", "resource-layer"},
    collision_box = {{-64/16 + 0.001, -32/16 + 0.001}, {64/16 - 0.001, 32/16 - 0.001}},
    selection_box = {{-64/16, -32/16}, {64/16, 32/16}},

    stage_counts = {0},
    stages = {
      sheet = {
        filename = "__starcraft__/graphics/hd/main_344_diffuse.png",
        priority = "extra-high",
        size = { 518, 268 },
        scale = 0.5,
        frame_count = 1,
        variation_count = 1
      }
    },
    map_color = {0/256, 228/256, 252/256},
    map_grid = true,

    tree_removal_probability = 1,
    tree_removal_max_distance = 8,
    randomize_visual_position = false,

    tile_width = 8,
    tile_height = 4,
    map_generator_bounding_box = {{-128/16, -96/16}, {128/16, 96/16}},
    autoplace = resource_autoplace.resource_autoplace_settings
    {
      name = "starcraft-resources",
      order = "d",
      base_density = 0.5,
      random_probability = 1/12,
      random_spot_size_minimum = 1,
      random_spot_size_maximum = 1,
      has_starting_area_placement = nil,
      regular_rq_factor_multiplier = 1,
      regular_blob_amplitude_multiplier = 1,
      seed1 = 1337,
      richness_post_multiplier = 0.4,
      minimum_richness = 1000,
      additional_richness = 400,
      candidate_spot_count = 64
    },

    infinite = true,
    minimum = 1,
    normal = 5000,
    infinite_depletion_amount = 8,
    minable = {
      mining_time = (75 * 42)/1000 /10,-- / 60, -- ((75 frames * 42ms/frame) / 1000ms/s) / 60ticks/s
      results = {
        { "starcraft-vespene-gas-tank", 8 }
      }
    },
    remove_decoratives = "true",
    resource_patch_search_radius = 16,
    created_effect = {
      type = "direct",
      action_delivery = {
        type = "instant",
        target_effects = {
          type = "script",
          effect_id = "on_vespene_geyser_created"
        }
      }
    }
  }
})
