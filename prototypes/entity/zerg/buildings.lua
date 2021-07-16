require("prototypes.entity.helpers")

data:extend({
    make_zerg_structure{
        name = "starcraft-hatchery",
        crafting_categories = {
            "starcraft-hatchery",
            "starcraft-hatchery-upgrades"
        },
        animation = create_layered_anim({
            name = "main_070",
            line_length = 6,
            size = { 259, 204 },
            hr_line_length = 6,
            hr_size = { 520, 408 },

            frame_count = 6,
            frame_sequence = { 1, 2, 3, 4, 3, 2, 1 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        corpse = "starcraft-z_bldg_rubble_lrg",
        dying_explosion = "starcraft-z_bldg_death_sml",
        max_health = 1250,
        collision_box = sc_bounds_to_factorio{49, 32, 49, 32},
        tile_height = 6,
        tile_width = 8
    },

})