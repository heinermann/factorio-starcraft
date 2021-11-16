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
        subgroup = "starcraft-protoss-ground-units",
        --dying_explosion = "starcraft-probe-death",
        max_health = 20,
        size_type = "small",

        braking_force = 1,
        friction_force = 1,
        weight = 1,
        terrain_friction_modifier = 1,
        rotation_speed = 1,

        animation = make_common_states(
            {
                name = "main_137",
                size = { 66, 66 },
                hr_size = { 132, 132 },
                vshift = -6/16
            },
            {
                filename = "main_137_shadow.png",
                size = { 92, 52 },
                hr_size = { 184, 105 },
                vshift = -6/16
            }
        ),
        has_belt_immunity = true,
        created_script = "on_protoss_unit_created",
        dying_script = "on_protoss_unit_destroyed"
    }
})
