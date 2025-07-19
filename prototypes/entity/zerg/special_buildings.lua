require("prototypes.entity.helpers")

data:extend({
--------------------------------------------------------------------------------------------------
-- THE OVERMIND
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-overmind",    -- with shell
        icon_id = 147,
        animation = create_layered_anim({
            name = "main_088",
            size = { 827, 572 },

            frame_count = 4,
            frame_sequence = { 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 2, 2, 1, 1, 1 },
            animation_speed = 1/2.5 -- 42ms in SC (1 ticks) -- because there's a wait 7 between frame 4 and 2 above
        }, {"main", "teamcolor", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_lrg", -- TODO - two-stage death anim
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 5000,
        armor = 1,
        collision_box = sc_bounds_to_factorio{80, 32, 79, 40},
        tile_height = 6,
        tile_width = 10,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -3/16
    },
--------------------------------------------------------------------------------------------------
-- OVERMIND WITH SHELL
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-overmind-2",  -- without shell
        icon_id = 148,
        animation = create_layered_anim({
            name = "main_089",
            size = { 827, 516 },

            frame_count = 4,
            frame_sequence = { 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 2, 2, 1, 1, 1 },
            animation_speed = 1/2.5 -- 42ms in SC (1 ticks) -- because there's a wait 7 between frame 4 and 2 above
        }, {"main", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 2500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{80, 32, 79, 40},
        tile_height = 6,
        tile_width = 10,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -3/16
    },
--------------------------------------------------------------------------------------------------
-- OVERMIND COCOON
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-overmind-cocoon",
        icon_id = 201,
        animation = create_layered_anim({
            name = "main_923",
            size = { 576, 392 },

            frame_count = 4,
            frame_sequence = { 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 4, 4, 2, 2, 1, 1, 1 },
            animation_speed = 1/2.5 -- 42ms in SC (1 ticks) -- because there's a wait 7 between frame 4 and 2 above
        }, {"main", "emissive"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 2500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{48, 32, 47, 31},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -7/16
    },
--------------------------------------------------------------------------------------------------
-- MATURE CHRYSALIS
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-mature-chrysalis",
        icon_id = 150,
        animation = create_layered_anim({
            name = "main_078",
            size = { 179, 210 },

            frame_count = 4,
            frame_sequence = { 1, 2, 3, 4 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 250,
        armor = 1,
        collision_box = sc_bounds_to_factorio{32, 32, 31, 31},
        tile_height = 4,
        tile_width = 4,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -11/16
    },
--------------------------------------------------------------------------------------------------
-- ZERG CEREBRATE
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-cerebrate",
        icon_id = 151,
        animation = create_layered_anim({
            name = "main_061",
            size = { 409, 252 },

            frame_count = 5,
            frame_sequence = { 1, 2, 3, 4, 5 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 32, 31},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -2/16
    },
--------------------------------------------------------------------------------------------------
-- CEREBRATE DAGGOTH
--------------------------------------------------------------------------------------------------
    make_zerg_structure{
        name = "starcraft-daggoth",
        icon_id = 152,
        animation = create_layered_anim({
            name = "main_061",
            size = { 409, 252 },

            frame_count = 5,
            frame_sequence = { 1, 2, 3, 4, 5 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_sml",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1500,
        armor = 1,
        collision_box = sc_bounds_to_factorio{40, 32, 32, 31},
        tile_height = 4,
        tile_width = 6,
        created_script = "on_creep_bldg_created",
        dying_script = "on_creep_bldg_destroyed",
        vshift = -2/16
    }
})
