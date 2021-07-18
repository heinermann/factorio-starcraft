require("prototypes.entity.helpers")
local table = require('__stdlib__/stdlib/utils/table')


local nexus_main = {
    name = "main_179",
    size = { 291, 311 },
    hr_size = { 582, 622 }
}
local nexus_overlay = {
    filename = "main_181_diffuse.png",
    size = { 239, 311 },
    hr_size = { 478, 622 },
    draw_as_glow = true
}

local robo_facility_main = {
    name = "main_192",
    size = { 193, 256 },
    hr_size = { 386, 512 }
}

local pylon_main = {
    name = "main_189",
    size = { 112, 129 },
    hr_size = { 223, 258 }
}

local assimilator_main = {
    name = "main_158",
    size = { 248, 235 },
    hr_size = { 494, 469 }
}

local observatory_main = {
    name = "main_161",
    size = { 195, 190 },
    hr_size = { 390, 380 }
}

local gateway_main = {
    name = "main_171",
    size = { 253, 248 },
    hr_size = { 506, 497 }
}

local citadel_main = {
    name = "main_164",
    size = { 196, 203 },
    hr_size = { 392, 404 }
}

local cyber_core_main = {
    name = "main_174",
    size = { 174, 217 },
    hr_size = { 349, 434 },
}

local archives_main = {
    name = "main_155",
    size = { 303, 367 },
    hr_size = { 606, 735 }
}

local forge_main = {
    name = "main_167",
    size = { 193, 176 },
    hr_size = { 385, 352 },
}

local stargate_main = {
    name = "main_199",
    size = { 248, 264 },
    hr_size = { 496, 528 },
}

local stargate_overlay = {
    filename = "main_200_diffuse.png",
    size = { 204, 144 },
    hr_size = { 408, 288 },
    draw_as_glow = true
}

local fleet_beacon_main = {
    name = "main_208",
    size = { 266, 210 },
    hr_size = { 533, 421 }
}

local tribunal_main = {
    name = "main_186",
    size = { 186, 172 },
    hr_size = { 373, 342 }
}

local robotics_support_main = {
    name = "main_204",
    size = { 202, 213 },
    hr_size = { 403, 427 }
}

local shield_battery_main = {
    name = "main_195",
    size = { 169, 118 },
    hr_size = { 337, 237 },
}

local shield_battery_overlay = {
    filename = "main_196_diffuse.png",
    size = { 185, 142 },
    hr_size = { 369, 285 },
    draw_as_glow = true
}

local function make_common_states(data)
    return {
        create_layered_anim(data, {"main", "teamcolor", "emissive"}),     -- idle
        create_layered_anim(data, {"main", "teamcolor", "emissive"}),     -- working
        create_layered_anim(data, {"main", "teamcolor"})                  -- disabled
    }
end

data:extend({
--------------------------------------------------------------------------------------------------
-- NEXUS
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-nexus",
        animation = {
            {   -- idle
                layers = {
                    create_layered_anim(nexus_main, {"main", "teamcolor", "emissive"}),
                    create_anim(nexus_overlay)
                }
            },
            {   -- working anim
                layers = {
                    create_layered_anim(table.dictionary_merge(nexus_main, {
                        repeat_count = 4,
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }), {"main", "teamcolor", "emissive"}),
                    create_anim(table.dictionary_merge(nexus_overlay, {
                        frame_count = 5,
                        frame_sequence = { 2, 3, 4, 5 },
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }))
                }
            }
        },
        corpse = "starcraft-p_bldg_rubble_lrg",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 750,   -- +750 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{56, 39, 56, 39},
        tile_height = 6,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- ROBOTICS FACILITY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-robotics-facility",
        pictures = make_common_states(robo_facility_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 16, 40, 20},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- PYLON
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-pylon",
        picture = create_layered_anim(pylon_main, {"main", "teamcolor", "emissive"}),
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 300,   -- +300 shields
        armor = 0,
        collision_box = sc_bounds_to_factorio{16, 12, 16, 20},
        tile_height = 4,
        tile_width = 4
    },
--------------------------------------------------------------------------------------------------
-- ASSIMILATOR
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-assimilator",
        picture = create_layered_anim(assimilator_main, {"main", "teamcolor", "emissive"}),
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 24},
        tile_height = 4,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- OBSERVATORY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-observatory",
        pictures = make_common_states(observatory_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 250,   -- +250 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 16, 44, 28},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- GATEWAY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-gateway",
        pictures = make_common_states(gateway_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 40},
        tile_height = 6,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- CANNON (TODO)
--------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------
-- CITADEL OF ADUN
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-citadel",
        pictures = make_common_states(citadel_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{24, 24, 40, 24},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- CYBERNETICS CORE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-cyber-core",
        animation = {
            -- idle
            create_layered_anim(cyber_core_main, {"main", "teamcolor", "emissive"}),
            {   -- working anim
                layers = {
                    create_layered_anim(table.dictionary_merge(cyber_core_main, {
                        repeat_count = 2,
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }), {"main", "teamcolor", "emissive"}),
                    create_layered_anim({
                        name = "main_176",
                        size = { 174, 217 },
                        hr_size = { 349, 434 },

                        frame_count = 2,
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }, {"main", "teamcolor", "emissive"})
                }
            },
            -- disabled
            create_layered_anim(cyber_core_main, {"main", "teamcolor"}),
        },

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 24, 40, 24},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- TEMPLAR ARCHIVES
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-archives",
        pictures = make_common_states(archives_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 24, 32, 24},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- FORGE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-forge",
        animation = {   -- idle
            create_layered_anim(forge_main, {"main", "teamcolor", "emissive"}),
            {   -- working anim
                layers = {
                    create_layered_anim(table.dictionary_merge(forge_main, {
                        repeat_count = 3,
                        animation_speed = 1/7.5 -- 126ms in SC (3 ticks)
                    }), {"main", "teamcolor", "emissive"}),
                    create_layered_anim({
                        name = "main_168",
                        size = { 181, 104 },
                        hr_size = { 361, 208 },

                        frame_count = 3,
                        animation_speed = 1/7.5 -- 126ms in SC (3 ticks)
                    }, {"main"})
                }
            },
            -- disabled
            create_layered_anim(forge_main, {"main", "teamcolor"}),
        },

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 550,   -- +550 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 24, 36, 20},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- STARGATE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-stargate",
        animation = {
            {   -- idle
                layers = {
                    create_layered_anim(stargate_main, {"main", "teamcolor", "emissive"}),
                    create_anim(stargate_overlay)
                }
            },
            {   -- working anim
                layers = {
                    create_layered_anim(table.dictionary_merge(stargate_main, {
                        repeat_count = 9,
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }), {"main", "teamcolor", "emissive"}),
                    create_anim(table.dictionary_merge(stargate_overlay, {
                        frame_count = 2,
                        frame_sequence = { 1, 1, 2, 1, 2, 1, 1, 2, 1 },
                        animation_speed = 1/2.5 -- 42ms in SC (1 ticks)
                    }))
                }
            },
            -- disabled
            create_layered_anim(stargate_main, {"main", "teamcolor"})
        },

        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 600,   -- +600 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 40, 48, 32},
        tile_height = 6,
        tile_width = 8
    },
--------------------------------------------------------------------------------------------------
-- STASIS CELL/PRISON
--------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------
-- FLEET BEACON
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-fleet-beacon",
        pictures = make_common_states(fleet_beacon_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 47, 24},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- ARBITER TRIBUNAL
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-tribunal",
        pictures = make_common_states(tribunal_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 28, 44, 28},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- ROBOTICS SUPPORT BAY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-robotics-support-bay",
        pictures = make_common_states(robotics_support_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 32, 32, 20},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- SHIELD BATTERY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-shield-battery",
        animation = {
            {  -- idle
                layers = {
                    create_layered_anim(shield_battery_main, {"main", "teamcolor", "emissive"}),
                    create_anim(shield_battery_overlay)
                }
            },
            {   -- working anim
                layers = {
                    create_layered_anim(table.dictionary_merge(shield_battery_main, {
                        repeat_count = 2,
                        animation_speed = 1/5 -- 84ms in SC (2 ticks)
                    }), {"main", "teamcolor", "emissive"}),
                    create_anim(table.dictionary_merge(shield_battery_overlay, {
                        frame_count = 3,
                        frame_sequence = { 2, 3 },
                        animation_speed = 1/5 -- 84ms in SC (2 ticks)
                    }))
                }
            },
            -- disabled
            create_layered_anim(shield_battery_main, {"main", "teamcolor"})
        },

        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 200,   -- +200 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 16, 32, 16},
        tile_height = 4,
        tile_width = 6
    },
--------------------------------------------------------------------------------------------------
-- KHAYDARIN CRYSTAL FORMATION
--------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------
-- PROTOSS TEMPLE
--------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------
-- XEL'NAGA TEMPLE
--------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------
-- WARP GATE
--------------------------------------------------------------------------------------------------
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
