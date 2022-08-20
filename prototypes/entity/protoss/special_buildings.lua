require("prototypes.entity.helpers")

data:extend({
--------------------------------------------------------------------------------------------------
-- STASIS CELL/PRISON
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-stasis-cell",
        icon_id = 168,
        picture = {
            layers = {
                create_layered_anim({
                    name = "main_203",
                    size = { 240, 304 },
                    hr_size = { 480, 608 }
                }, {"main", "emissive"}),
                create_custom_shadow_anim({
                    filename = "stasis_cell_shad",
                    size = { 365, 109 },
                    hr_size = { 731, 219 },
                    vshift = 68 / 64,
                    hshift = (731 - 480) / 2 / 64
                })
            }
        },
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 2000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{64, 48, 63, 47},
        tile_height = 6,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- KHAYDARIN CRYSTAL FORMATION
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-khaydarin-crystal-formation",
        icon_id = 173,
        picture = create_layered_anim({
            name = "main_178",
            size = { 259, 256 },
            hr_size = { 518, 512 },
            vshift = -16/16
        }, {"main", "emissive"}),

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 100000,   -- TODO: make invincible (destructible = true)
        armor = 1,
        collision_box = sc_bounds_to_factorio{64, 48, 63, 47},
        tile_height = 6,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- PROTOSS TEMPLE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-protoss-temple",
        icon_id = 174,
        picture = create_layered_anim({
            name = "main_207",
            size = { 451, 308 },
            hr_size = { 902, 616 },
            vshift = -7/16
        }, {"main"}),

        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 1500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{112, 48, 111, 47},
        tile_height = 6,
        tile_width = 14
    },
--------------------------------------------------------------------------------------------------
-- XEL'NAGA TEMPLE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-xel-naga-temple",
        icon_id = 175,
        picture = {
            layers = {
                create_layered_anim({
                    name = "main_937",
                    size = { 385, 520 },
                    hr_size = { 769, 1040 },
                    vshift = -16/16
                }, {"main", "emissive"}),
                create_custom_shadow_anim({
                    filename = "xelnaga_shad",
                    size = { 522, 262 },
                    hr_size = { 1043, 523 },
                    vshift = 106 / 64 - 16/16,
                    hshift = (1043 - 769) / 2 / 64
                })
            }
        },
        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 5000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{80, 34, 79, 63},
        tile_height = 8,
        tile_width = 10
    },
--------------------------------------------------------------------------------------------------
-- WARP GATE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-warp-gate",
        icon_id = 189,
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
