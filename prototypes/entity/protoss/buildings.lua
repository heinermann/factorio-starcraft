require("prototypes.entity.helpers")

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
        picture = create_layered_anim({
            name = "main_192",
            size = { 193, 256 },
            hr_size = { 386, 512 }
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
        picture = create_layered_anim({
            name = "main_189",
            size = { 112, 129 },
            hr_size = { 223, 258 }
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
        picture = create_layered_anim({
            name = "main_158",
            size = { 248, 235 },
            hr_size = { 494, 469 }
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
        picture = create_layered_anim({
            name = "main_161",
            size = { 195, 190 },
            hr_size = { 390, 380 }
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
        picture = create_layered_anim({
            name = "main_171",
            size = { 253, 248 },
            hr_size = { 506, 497 }
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
        picture = create_layered_anim({
            name = "main_164",
            size = { 196, 203 },
            hr_size = { 392, 404 }
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
        picture = create_layered_anim({
            name = "main_155",
            size = { 303, 367 },
            hr_size = { 606, 735 }
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
        picture = create_layered_anim({
            name = "main_203",
            size = { 240, 304 },
            hr_size = { 480, 608 }
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
        picture = create_layered_anim({
            name = "main_208",
            size = { 266, 210 },
            hr_size = { 533, 421 }
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
        picture = create_layered_anim({
            name = "main_186",
            size = { 186, 172 },
            hr_size = { 373, 342 }
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
        picture = create_layered_anim({
            name = "main_204",
            size = { 202, 213 },
            hr_size = { 403, 427 }
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
        picture = create_layered_anim({
            name = "main_178",
            size = { 259, 256 },
            hr_size = { 518, 512 }
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
        picture = create_layered_anim({
            name = "main_207",
            size = { 451, 308 },
            hr_size = { 902, 616 }
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
        picture = create_layered_anim({
            name = "main_937",
            size = { 385, 520 },
            hr_size = { 769, 1040 }
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
        animation = {
            layers = {
                create_layered_anim({
                    name = "main_934",
                    size = { 247, 452 },
                    hr_size = { 493, 905 },

                    frame_count = 1,
                    repeat_count = 10,
                    animation_speed = 1/5 -- 84ms in SC (2 ticks)
                }, {"main", "emissive"}),
                create_anim({
                    filename = "main_936_diffuse.png",
                    size = { 103, 382 },
                    hr_size = { 207, 765 },

                    draw_as_glow = true,

                    frame_count = 6,
                    frame_sequence = { 1, 2, 3, 4, 5, 6, 5, 4, 3, 2 },
                    animation_speed = 1/5 -- 84ms in SC (2 ticks)
                })
            }
        },

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 700,
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 47, 31},
        tile_height = 4,
        tile_width = 6
    }
})
