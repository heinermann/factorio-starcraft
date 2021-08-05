local function append_transition_mask_template(normal_res_transition, high_res_transition, tab)
    local function make_transition_variation(x_, cnt_, line_len_)
        local t =
        {
            picture = normal_res_transition,
            count = cnt_,
            line_length = line_len_ or cnt_,
            x = x_
        }

        if high_res_transition then
        t.hr_version =
        {
            picture = high_res_transition,
            count = cnt_,
            line_length = line_len_ or cnt_,
            x = 2 * x_,
            scale = 0.5
        }
        end
        return t
    end

    tab["inner_corner_mask"] = make_transition_variation(0, 8)
    tab["outer_corner_mask"] = make_transition_variation(288, 8)
    tab["side_mask"]         = make_transition_variation(576, 8)
    tab["u_transition_mask"] = make_transition_variation(864, 1, 1)
    tab["o_transition_mask"] = make_transition_variation(1152, 1, 2)

    return tab
end

local edge = {
    picture = "__starcraft__/graphics/tiles/low/creep_main.png",
    size = 1,
    scale = 2,
    count = 1,
    hr_version = {
        picture = "__starcraft__/graphics/tiles/hd/creep_main.png",
        size = 1,
        scale = 1,
        count = 1,
    }
}

data:extend({
    {
        type = "tile",
        name = "zerg-creep",

        collision_mask = { "ground-tile" },
        layer = 120,
        --layer_group = "top",
        map_color = {80, 60, 72},
        pollution_absorption_per_second = 0,
        decorative_removal_probability = 1,
        can_be_part_of_blueprint = false,

        variants = append_transition_mask_template(
            "__starcraft__/graphics2/tile/creep-transition.png",
            "__starcraft__/graphics2/tile/hr-creep-transition.png",
            {
                main = {
                    {
                        picture = "__starcraft__/graphics/tiles/low/creep_main.png",
                        size = 1,
                        scale = 0.5,
                        count = 13,
                        weights = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.05*4, 0.05*4, 0.05*4, 0.05*4 },
                        hr_version = {
                            picture = "__starcraft__/graphics/tiles/hd/creep_main.png",
                            size = 1,
                            scale = 0.25,
                            count = 13,
                            weights = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.05*4, 0.05*4, 0.05*4, 0.05*4 },
                        }
                    }
                },
                empty_transitions = false,
                --side = edge,
                --inner_corner = edge,
                --outer_corner = edge,
                --u_transition = edge,
                --o_transition = edge
            }
        )
    }
  })
  