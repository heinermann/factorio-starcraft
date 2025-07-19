require("prototypes.entity.helpers")

local function make_common_states(data, shadow_data)
    local shadow_anim = nil
    if shadow_data then
        shadow_data.draw_as_shadow = true
        shadow_anim = create_anim(shadow_data)
    end

    return {
        layers = {
            create_layered_anim(data, {"main", "teamcolor", "emissive"}),     -- idle
            shadow_anim
        }
    }
end


data:extend({
    make_protoss_unit{
        name = "starcraft-probe",
        icon_id = 64,
        collision_box = sc_bounds_to_factorio{11, 11, 11, 11},
        --dying_explosion = "starcraft-probe-death",
        max_health = 20,
        size_type = "small",

        rotation_speed = 0.015,
        braking_force = 1,      -- or braking_power
        terrain_friction_modifier = 0,
        friction_force = 0.09733887815,
        weight = 1,
        effectivity = 1,
        consumption = tostring(32.8868891*60) .. "W",

        animation = make_common_states(
            {
                name = "main_137",
                size = { 132, 132 },
                vshift = -6/16,
                direction_count = 32
            },
            {
                filename = "main_137_shadow.png",
                size = { 184, 105 },
                vshift = -6/16,
                direction_count = 32
            }
        ),
        has_belt_immunity = true,
        created_script = "on_protoss_unit_created",
        dying_script = "on_protoss_unit_destroyed"
    }
})
