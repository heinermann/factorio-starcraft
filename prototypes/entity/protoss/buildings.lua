require("prototypes.entity.helpers")

-- TODO: Potential performance - A lot of these could be "picture" instead of "animation"

data:extend({
    make_protoss_structure{
        name = "starcraft-nexus",
        animation = create_layered_anim({
            name = "main_179",
            size = { 291, 311 },
            hr_size = { 582, 622 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 750,   -- +750 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{56, 39, 56, 39},
        tile_height = 6,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-robotics-facility",
        animation = create_layered_anim({
            name = "main_192",
            size = { 193, 256 },
            hr_size = { 386, 512 },

            line_length = 20,
            hr_line_length = 10,

            frame_count = 20,
            frame_sequence = { 1 },
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 16, 40, 20},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-pylon",
        animation = create_layered_anim({
            name = "main_189",
            size = { 112, 129 },
            hr_size = { 223, 258 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 300,   -- +300 shields
        armor = 0,
        collision_box = sc_bounds_to_factorio{16, 12, 16, 20},
        tile_height = 4,
        tile_width = 4
    },
    make_protoss_structure{
        name = "starcraft-assimilator",
        animation = create_layered_anim({
            name = "main_158",
            size = { 248, 235 },
            hr_size = { 494, 469 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 24},
        tile_height = 4,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-observatory",
        animation = create_layered_anim({
            name = "main_161",
            size = { 195, 190 },
            hr_size = { 390, 380 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 250,   -- +250 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 16, 44, 28},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-gateway",
        animation = create_layered_anim({
            name = "main_171",
            size = { 253, 248 },
            hr_size = { 506, 497 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 40},
        tile_height = 6,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-cannon",
        animation = create_layered_anim({
            name = "main_183",
            size = { 128, 129 },
            hr_size = { 256, 258 },

            frame_count = 4,
            frame_sequence = { 1 },
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 100,   -- +100 shields
        armor = 0,
        collision_box = sc_bounds_to_factorio{20, 16, 20, 16},
        tile_height = 4,
        tile_width = 4
    },
    make_protoss_structure{
        name = "starcraft-citadel",
        animation = create_layered_anim({
            name = "main_164",
            size = { 196, 203 },
            hr_size = { 392, 404 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{24, 24, 40, 24},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-cyber-core",
        animation = create_layered_anim({
            name = "main_174",
            size = { 174, 217 },
            hr_size = { 349, 434 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 24, 40, 24},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-archives",
        animation = create_layered_anim({
            name = "main_155",
            size = { 303, 367 },
            hr_size = { 606, 735 },

            frame_count = 2,
            frame_sequence = { 1 },
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 24, 32, 24},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-forge",
        animation = create_layered_anim({
            name = "main_167",
            size = { 193, 176 },
            hr_size = { 385, 352 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 550,   -- +550 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 24, 36, 20},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-stargate",
        animation = create_layered_anim({
            name = "main_199",
            size = { 248, 264 },
            hr_size = { 496, 528 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 600,   -- +600 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 40, 48, 32},
        tile_height = 6,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-stasis-cell",
        animation = create_layered_anim({
            name = "main_203",
            size = { 240, 304 },
            hr_size = { 480, 608 },

            frame_count = 1,
        }, {"main", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 2000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{64, 48, 63, 47},
        tile_height = 6,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-fleet-beacon",
        animation = create_layered_anim({
            name = "main_208",
            size = { 266, 210 },
            hr_size = { 533, 421 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 47, 24},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-tribunal",
        animation = create_layered_anim({
            name = "main_186",
            size = { 186, 172 },
            hr_size = { 373, 342 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 28, 44, 28},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-robotics-support-bay",
        animation = create_layered_anim({
            name = "main_204",
            size = { 202, 213 },
            hr_size = { 403, 427 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 32, 32, 20},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-shield-battery",
        animation = create_layered_anim({
            name = "main_195",
            size = { 169, 118 },
            hr_size = { 337, 237 },

            frame_count = 1,
        }, {"main", "teamcolor", "emissive"}),

        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 200,   -- +200 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 16, 32, 16},
        tile_height = 4,
        tile_width = 6
    },
    make_protoss_structure{
        name = "starcraft-khaydarin-crystal-formation",
        animation = create_layered_anim({
            name = "main_178",
            size = { 259, 256 },
            hr_size = { 518, 512 },

            frame_count = 1,
        }, {"main", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 100000,   -- TODO: make invincible (destructible = true)
        armor = 1,
        collision_box = sc_bounds_to_factorio{64, 48, 63, 47},
        tile_height = 6,
        tile_width = 8
    },
    make_protoss_structure{
        name = "starcraft-protoss-temple",
        animation = create_layered_anim({
            name = "main_207",
            size = { 451, 308 },
            hr_size = { 902, 616 },

            frame_count = 1,
        }, {"main"}),

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 1500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{112, 48, 111, 47},
        tile_height = 6,
        tile_width = 14
    },
    make_protoss_structure{
        name = "starcraft-xel-naga-temple",
        animation = create_layered_anim({
            name = "main_937",
            size = { 385, 520 },
            hr_size = { 769, 1040 },

            frame_count = 1,
        }, {"main", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 5000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{80, 34, 79, 63},
        tile_height = 8,
        tile_width = 10
    },
    make_protoss_structure{
        name = "starcraft-warp-gate",
        animation = create_layered_anim({
            name = "main_934",
            size = { 247, 452 },
            hr_size = { 493, 905 },

            frame_count = 1,
        }, {"main", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 700,
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 47, 31},
        tile_height = 4,
        tile_width = 6
    }
})
