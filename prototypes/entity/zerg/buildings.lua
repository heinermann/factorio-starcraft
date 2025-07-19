require("prototypes.entity.helpers")

data:extend({
--------------------------------------------------------------------------------------------------
-- HATCHERY
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-hatchery",
        icon_id = 131,
        animation = create_layered_anim({
            name = "main_070",
            size = { 520, 408 },

            frame_count = 6,
            frame_sequence = { 1, 2, 3, 4, 4, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1250,
        armor = 1,
        collision_box = sc_bounds_to_factorio{49, 32, 49, 32},
        tile_height = 6,
        tile_width = 8,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -7/16
    },
--------------------------------------------------------------------------------------------------
-- LAIR
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-lair",
        icon_id = 132,
        animation = create_layered_anim({
            name = "main_074",
            size = { 524, 523 },

            frame_count = 5,
            frame_sequence = { 1, 2, 3, 4, 4, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1800,
        armor = 1,
        collision_box = sc_bounds_to_factorio{49, 32, 49, 32},
        tile_height = 6,
        tile_width = 8,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -7/16
    },
--------------------------------------------------------------------------------------------------
-- HIVE
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-hive",
        icon_id = 133,
        animation = create_layered_anim({
            name = "main_072",
            size = { 508, 685 },

            frame_count = 5,
            frame_sequence = { 1, 2, 3, 4, 4, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 2500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{49, 32, 49, 32},
        tile_height = 6,
        tile_width = 8,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -7/16
    },
--------------------------------------------------------------------------------------------------
-- NYDUS CANAL
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-nydus",
        icon_id = 134,
        animation = create_layered_anim({
            name = "main_086",
            size = { 283, 328 },

            frame_count = 5,
            frame_sequence = { 1, 2, 3, 4, 4, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 250,
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 32, 31, 31},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -5/16
    },
--------------------------------------------------------------------------------------------------
-- HYDRALISK DEN
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-hydra-den",
        icon_id = 135,
        animation = create_layered_anim({
            name = "main_095",
            size = { 428, 468 },

            frame_count = 3,
            frame_sequence = { 1, 2, 3, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 850,
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 40, 24},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -9/16
    },
--------------------------------------------------------------------------------------------------
-- DEFILER MOUND
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-defiler-mound",
        icon_id = 136,
        animation = create_layered_anim({
            name = "main_082",
            size = { 459, 420 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 2 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 850,
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 48, 4},
        tile_height = 4,
        tile_width = 8,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
    },
--------------------------------------------------------------------------------------------------
-- GREATER SPIRE
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-greater-spire",
        icon_id = 137,
        animation = create_layered_anim({
            name = "main_080",
            size = { 317, 588 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{28, 32, 28, 24},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -10/16
    },
--------------------------------------------------------------------------------------------------
-- QUEEN'S NEST
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-queens-nest",
        icon_id = 138,
        animation = create_layered_anim({
            name = "main_084",
            size = { 316, 395 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 850,
        armor = 1,
        collision_box = sc_bounds_to_factorio{38, 28, 32, 28},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -11/16
    },
--------------------------------------------------------------------------------------------------
-- EVOLUTION CHAMBER
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-evo-chamber",
        icon_id = 139,
        animation = create_layered_anim({
            name = "main_066",
            size = { 392, 458 },

            frame_count = 3,
            frame_sequence = { 1, 2, 3 },
            animation_speed = 1/7.5 -- 126ms in SC (3 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 750,
        armor = 1,
        collision_box = sc_bounds_to_factorio{44, 32, 32, 20},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -5/16
    },
--------------------------------------------------------------------------------------------------
-- ULTRALISK CAVERN
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-ultra-cavern",
        icon_id = 140,
        animation = create_layered_anim({
            name = "main_091",
            size = { 388, 464 },

            frame_count = 3,
            frame_sequence = { 1, 2, 3, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 600,
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 32, 31},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -6/16
    },
--------------------------------------------------------------------------------------------------
-- SPIRE
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-spire",
        icon_id = 141,
        animation = create_layered_anim({
            name = "main_097",
            size = { 267, 520 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 600,
        armor = 1,
        collision_box = sc_bounds_to_factorio{28, 32, 28, 24},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -10/16
    },
--------------------------------------------------------------------------------------------------
-- SPAWNING POOL
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-spawning-pool",
        icon_id = 142,
        animation = create_layered_anim({
            name = "main_064",
            size = { 386, 283 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 4 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 750,
        armor = 1,
        collision_box = sc_bounds_to_factorio{36, 28, 40, 18},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -1/16
    },
--------------------------------------------------------------------------------------------------
-- CREEP COLONY
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-creep-colony",
        icon_id = 143,
        animation = create_layered_anim({
            name = "main_068",
            size = { 275, 231 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 4 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 400,
        armor = 0,
        collision_box = sc_bounds_to_factorio{24, 24, 23, 23},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -11/16
    },
--------------------------------------------------------------------------------------------------
-- SPORE COLONY
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-spore-colony",
        icon_id = 144,
        animation = create_layered_anim({
            name = "main_099",
            size = { 278, 345 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 4 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 400,
        armor = 0,
        collision_box = sc_bounds_to_factorio{24, 24, 23, 23},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -11/16
    },
--------------------------------------------------------------------------------------------------
-- SUNKEN COLONY
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-sunken-colony",
        icon_id = 146,
        animation = create_layered_anim({
            name = "main_076",
            size = { 349, 347 },
            line_length = 11,

            frame_count = 34,
            frame_sequence = { 1, 2, 3 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 300,
        armor = 2,
        collision_box = sc_bounds_to_factorio{24, 24, 23, 23},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_provider_created",
        dying_script = "on_creep_provider_destroyed",
        vshift = -3/16
    },
--------------------------------------------------------------------------------------------------
-- EXTRACTOR
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        -- TODO: gas overlays
        name = "starcraft-extractor",
        icon_id = 149,
        animation = create_layered_anim({
            name = "main_093",
            size = { 498, 683 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 4, 3, 2 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor", "emissive"}),

        corpse = nil,
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 750,
        armor = 1,
        collision_box = sc_bounds_to_factorio{64, 32, 63, 31},
        tile_height = 4,
        tile_width = 8,
        created_script = "on_extractor_created"
    }
})