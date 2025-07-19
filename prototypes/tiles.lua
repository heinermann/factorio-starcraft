local function transition_masks()
    local function make_transition_variation(x_, cnt_, line_len_)
        return {
            spritesheet = "__starcraft__/graphics2/tile/hr-creep-transition.png",
            count = cnt_,
            line_length = line_len_ or cnt_,
            x = 2 * x_,
            scale = 0.5
        }
    end

    return {
        mask_spritesheet = "__starcraft__/graphics/tiles/hd/creep_background.png",
        mask_layout = {
            scale = 0.5,
            size = 1,
            count = 64,
            line_length = 8,
            inner_corner = make_transition_variation(0, 8),
            outer_corner = make_transition_variation(288, 8),
            side         = make_transition_variation(576, 8),
            u_transition = make_transition_variation(864, 1, 1),
            o_transition = make_transition_variation(1152, 1, 2),
        },
    }
end

--local edge = {
--    picture = "__starcraft__/graphics/tiles/hd/creep_main.png",
--    size = 1,
--    scale = 1,
--    count = 1,
--}

data:extend({
    {
        type = "tile",
        name = "zerg-creep",

        collision_mask = {
            layers = {
                ground_tile = true,
                object = true
            }
        },
        layer = 120,
        map_color = {80, 60, 72},
        absorptions_per_second = {},
        decorative_removal_probability = 1,
        can_be_part_of_blueprint = false,

        variants = {
            transition = transition_masks(),
            main = {
                {
                    picture = "__starcraft__/graphics/tiles/hd/creep_main.png",
                    size = 1,
                    scale = 0.25,
                    count = 13,
                    weights = { 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.05*4, 0.05*4, 0.05*4, 0.05*4 },
                }
            },
            material_background = {
                picture = "__starcraft__/graphics/tiles/hd/creep_background.png",
                size = 1,
                scale = 0.5,
                count = 64,
                line_length = 8,
            },
        }
    }
  })
  