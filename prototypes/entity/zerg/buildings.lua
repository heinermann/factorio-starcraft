require("prototypes.entity.helpers")

local zerg_buildings = {
    {
        name = "starcraft-hatchery",
        crafting_categories = {
            "starcraft-hatchery",
            "starcraft-hatchery-upgrades"
        },
        animation = create_unit_anim({
            name = "main_070",
            line_length = 6,
            size = { 259, 204 },
            hr_line_length = 3,
            hr_size = { 520, 408 },

            frame_count = 6,
            frame_sequence = { 0, 1, 2, 3, 2, 1, 0 },
            animation_speed = 1/5 -- 84ms in SC (2 ticks)
        }, {"main", "teamcolor"}),

        --corpse = "SPR_Z_BLDG_RUBBLE_LRG",
        --dying_explosion = "IMG_Z_BLDG_DEATH_SML",
        max_health = 1250,
        collision_box = sc_bounds_to_factorio{49, 32, 49, 32},
        tile_height = 6,
        tile_width = 8
    },

}