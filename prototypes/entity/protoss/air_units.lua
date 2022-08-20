require("prototypes.entity.helpers")

local blank_anim = {
    filename = "__starcraft__/graphics2/blank.png",
    frame_count = 1,
    size = {1, 1},
    direction_count = 1
}

data:extend({
    {
        type = "animation",
        name = "starcraft-scout-anim-main",
        layers = {
            create_layered_anim({
                name = "main_140",
                size = { 115, 84 },
                hr_size = { 230, 166 },
                vshift = -7/16,
                direction_count = 32
            }, {"main", "teamcolor", "emissive"})
        }
    },
    {
        type = "animation",
        name = "starcraft-scout-anim-shadow",
        layers = {
            create_shadow_anim({
                filename = "main_140_shadow",
                size = { 117, 92 },
                hr_size = { 232, 184 },
                vshift = 3,
                hshift = 3,
                direction_count = 32
            })
        }
    },
    {
        type = "animation",
        name = "starcraft-scout-anim-ground-attack",
        layers = {
            create_layered_anim({
                name = "main_140",
                size = { 115, 84 },
                hr_size = { 230, 166 },
                vshift = -7/16,
                direction_count = 32,
                frame_count = 2,
                frame_sequence = { 2, 2, 1, 1, 2, 2, 1, 1, 2, 2, 1, 1 },
            }, {"main", "teamcolor", "emissive"})
        }
    },
    {
        type = "animation",
        name = "starcraft-scout-anim-air-attack",
        layers = {
            create_layered_anim({
                name = "main_140",
                size = { 115, 84 },
                hr_size = { 230, 166 },
                vshift = -7/16,
                direction_count = 32,
                frame_count = 2,
                frame_sequence = { 2, 2, 1, 1 },
            }, {"main", "teamcolor", "emissive"})
        }
    },
    --{
    --    type = "animation",
    --    name = "starcraft-scout-anim-jets",
    --    -- ?? sheet?
    --},

    make_protoss_air_unit{
        name = "starcraft-scout",
        icon_id = 70,
        collision_box = sc_bounds_to_factorio{18, 16, 17, 15},
        --dying_explosion = "starcraft-scout-death",
        max_health = 150,
        size_type = "large",

        rotation_speed = 0.015,
        braking_force = 1,      -- or braking_power
        terrain_friction_modifier = 0,
        friction_force = 0.09733887815,
        weight = 1,
        effectivity = 1,
        consumption = tostring(32.8868891*60) .. "W",

        animation = blank_anim,
        render_layer = "air-entity-info-icon", -- Should be "146" instead but that is invalid here
        created_script = "on_scout_created",
        dying_script = "on_protoss_unit_destroyed",
        --stop_script = "return_to_idle_anim"
    }
})
