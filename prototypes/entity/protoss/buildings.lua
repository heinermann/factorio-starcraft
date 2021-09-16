require("prototypes.entity.helpers")
local table = require('__stdlib__/stdlib/utils/table')


local nexus_main = {
    name = "main_179",
    size = { 291, 311 },
    hr_size = { 582, 622 },
    vshift = -4/16
}
local nexus_overlay = {
    filename = "main_181_diffuse.png",
    size = { 239, 311 },
    hr_size = { 478, 622 },
    draw_as_glow = true,
    vshift = -4/16
}

local nexus_shadow = {
    filename = "nexus_shad",
    size = { 392, 311 },
    hr_size = { 785, 622 },
    vshift = -4/16,
    hshift = 203/64 / 2
}

local robo_facility_main = {
    name = "main_192",
    size = { 193, 256 },
    hr_size = { 386, 512 },
    vshift = -8/16
}

local pylon_main = {
    name = "main_189",
    size = { 112, 129 },
    hr_size = { 223, 258 },
    vshift = -11/16
}

local pylon_shadow = {
    filename = "pylon_shad",
    size = { 155, 54 },
    hr_size = { 310, 107 },
    vshift = 258 / 2 / 64 - 10/16,
    hshift = 310 / 64 / 2 + 1/16
}

local assimilator_main = {
    name = "main_158",
    size = { 248, 235 },
    hr_size = { 494, 469 }
}

local observatory_main = {
    name = "main_161",
    size = { 195, 190 },
    hr_size = { 390, 380 },
    vshift = -8/16
}

local observatory_shadow = {
    filename = "observatory_shad",
    size = { 300, 190 },
    hr_size = { 600, 380 },
    vshift = -8/16,
    hshift = (600 - 390) / 2 / 64
}

local gateway_main = {
    name = "main_171",
    size = { 253, 248 },
    hr_size = { 506, 497 },
    vshift = -11/16
}

local citadel_main = {
    name = "main_164",
    size = { 196, 203 },
    hr_size = { 392, 404 },
    vshift = -13/16
}

local cyber_core_main = {
    name = "main_174",
    size = { 174, 217 },
    hr_size = { 349, 434 },
    vshift = -1/16
}

local archives_main = {
    name = "main_155",
    size = { 303, 367 },
    hr_size = { 606, 735 },
    vshift = -5/16
}

local forge_main = {
    name = "main_167",
    size = { 193, 176 },
    hr_size = { 385, 352 },
    vshift = -1/16
}

local stargate_main = {
    name = "main_199",
    size = { 248, 264 },
    hr_size = { 496, 528 },
    vshift = -16/16
}

local stargate_overlay = {
    filename = "main_200_diffuse.png",
    size = { 204, 144 },
    hr_size = { 408, 288 },
    draw_as_glow = true,
    vshift = -16/16
}

local fleet_beacon_main = {
    name = "main_208",
    size = { 266, 210 },
    hr_size = { 533, 421 },
    vshift = -7/16
}

local tribunal_main = {
    name = "main_186",
    size = { 186, 172 },
    hr_size = { 373, 342 },
    vshift = -4/16
}

local robotics_support_main = {
    name = "main_204",
    size = { 202, 213 },
    hr_size = { 403, 427 },
    vshift = -6/16
}

local shield_battery_main = {
    name = "main_195",
    size = { 169, 118 },
    hr_size = { 337, 237 },
    vshift = -3/16
}

local shield_battery_overlay = {
    filename = "main_196_diffuse.png",
    size = { 185, 142 },
    hr_size = { 369, 285 },
    draw_as_glow = true,
    vshift = -3/16
}

local function make_photon_cannon_anim(frame_seq)
    return create_layered_anim({
        name = "main_183",
        size = { 128, 129 },
        hr_size = { 256, 258 },
        frame_count = 4,
        frame_sequence = frame_seq,
        animation_speed = 1/5, -- 84ms in SC (2 ticks)
        vshift = -2/16
    }, {"main", "teamcolor", "emissive"})
end

local function make_common_states(data, shadow_data)
    local shadow_anim = nil
    if shadow_data then
        shadow_anim = create_shadow_anim(shadow_data)
    end

    return {
        {
            layers = {
                create_layered_anim(data, {"main", "teamcolor", "emissive"}),     -- idle
                shadow_anim
            }
        },
        {
            layers = {
                create_layered_anim(data, {"main", "teamcolor", "emissive"}),     -- working
                shadow_anim
            }
        },
        {
            layers = {
                create_layered_anim(data, {"main", "teamcolor"}),                  -- disabled
                shadow_anim
            }
        }
    }
end

data:extend({
--------------------------------------------------------------------------------------------------
-- NEXUS
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-nexus",
        icon_id = 154,
        animation = {
            {   -- idle
                layers = {
                    create_layered_anim(nexus_main, {"main", "teamcolor", "emissive"}),
                    create_anim(nexus_overlay),
                    create_shadow_anim(nexus_shadow)
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
                    })),
                    create_shadow_anim(table.dictionary_merge(nexus_shadow, {
                        repeat_count = 4,
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
        tile_width = 8,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- ROBOTICS FACILITY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-robotics-facility",
        icon_id = 155,
        pictures = make_common_states(robo_facility_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 16, 40, 20},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- PYLON
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-pylon",
        icon_id = 156,
        picture = {
            layers = {
                create_layered_anim(pylon_main, {"main", "teamcolor", "emissive"}),
                create_shadow_anim(pylon_shadow)
            }
        },
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 300,   -- +300 shields
        armor = 0,
        collision_box = sc_bounds_to_factorio{16, 12, 16, 20},
        tile_height = 4,
        tile_width = 4,
        dying_script = "on_protoss_pylon_destroyed",
        created_script = "on_protoss_pylon_created"
    },
--------------------------------------------------------------------------------------------------
-- ASSIMILATOR
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-assimilator",
        icon_id = 157,
        picture = create_layered_anim(assimilator_main, {"main", "teamcolor", "emissive"}),
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 24},
        tile_height = 4,
        tile_width = 8,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- OBSERVATORY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-observatory",
        icon_id = 159,
        pictures = make_common_states(observatory_main, observatory_shadow),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 250,   -- +250 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 16, 44, 28},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- GATEWAY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-gateway",
        icon_id = 160,
        pictures = make_common_states(gateway_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 40},
        tile_height = 6,
        tile_width = 8,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- PHOTON CANNON
--------------------------------------------------------------------------------------------------
    protossify_prototype(make_functional_turret{
        name = "starcraft-cannon",
        icon_id = 162,
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 100,   -- +100 shields
        armor = 0,
        collision_box = sc_bounds_to_factorio{20, 16, 20, 16},
        tile_height = 4,
        tile_width = 4,

        folded_animation = make_photon_cannon_anim{ 1 },
        folded_speed = 1/5,
        folding_animation = make_photon_cannon_anim{ 2, 3 },
        folding_speed = 1/5,
        preparing_animation = make_photon_cannon_anim{ 3, 2, 4 },
        preparing_speed = 1/5,
        attacking_animation = make_photon_cannon_anim{ 4 },
        attacking_speed = 1/5,
        prepared_animation = make_photon_cannon_anim{ 4 },
        prepared_speed = 1/5,

        attack_parameters = {
            type = "projectile",
            -- BUG: Added 2 tiles because it doesn't compute from bounding box
            -- +small amount to prevent being outranged by the pistol or spitters
            range = 14 + 2 + 0.75,
            cooldown = sc_ticks_to_factorio_ticks(22 - 1),
            range_mode = "bounding-box-to-bounding-box",    -- BUG: This is unsupported for turrets
            cooldown_deviation = 0.05,  -- TODO: figure out what this *actually* does??
            warmup = sc_ticks_to_factorio_ticks(2),
            sound = {
                filename = "__starcraft__/sound/bullet/dragbull.wav",
                aggregation = {
                    max_count = 4,
                    remove = false
                }
            },
            projectile_center = { 0, -sc_pixels_to_factorio_tiles(20)/2 },
            ammo_type = {
                category = "bullet",
                action = {
                    type = "direct",
                    action_delivery = {
                        type = "projectile",
                        projectile = "starcraft-sts_sta_photon_cannon",
                        starting_speed = 0
                    }
                }
            }
        },
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    }),
--------------------------------------------------------------------------------------------------
-- CITADEL OF ADUN
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-citadel",
        icon_id = 163,
        pictures = make_common_states(citadel_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{24, 24, 40, 24},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- CYBERNETICS CORE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-cyber-core",
        icon_id = 164,
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
                        animation_speed = 1/2.5, -- 42ms in SC (1 ticks)
                        vshift = -1/16
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
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- TEMPLAR ARCHIVES
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-archives",
        icon_id = 165,
        pictures = make_common_states(archives_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 24, 32, 24},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- FORGE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-forge",
        icon_id = 166,
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
                        animation_speed = 1/7.5, -- 126ms in SC (3 ticks)
                        vshift = -1/16
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
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- STARGATE
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-stargate",
        icon_id = 167,
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
        tile_width = 8,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
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
                create_shadow_anim({
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
-- FLEET BEACON
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-fleet-beacon",
        icon_id = 169,
        pictures = make_common_states(fleet_beacon_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 47, 24},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- ARBITER TRIBUNAL
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-tribunal",
        icon_id = 170,
        pictures = make_common_states(tribunal_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 500,   -- +500 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 28, 44, 28},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- ROBOTICS SUPPORT BAY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-robotics-support-bay",
        icon_id = 171,
        pictures = make_common_states(robotics_support_main),
        corpse = "starcraft-p_bldg_rubble_sml",
        dying_explosion = "starcraft-p_explode_death_xlrg",
        max_health = 450,   -- +450 shields
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 32, 32, 20},
        tile_height = 4,
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
    },
--------------------------------------------------------------------------------------------------
-- SHIELD BATTERY
--------------------------------------------------------------------------------------------------
    make_protoss_structure{
        name = "starcraft-shield-battery",
        icon_id = 172,
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
        tile_width = 6,
        dying_script = "on_protoss_bldg_destroyed",
        created_script = "on_protoss_powered_bldg_created"
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
        picture = create_layered_anim({
            name = "main_937",
            size = { 385, 520 },
            hr_size = { 769, 1040 },
            vshift = -16/16
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
