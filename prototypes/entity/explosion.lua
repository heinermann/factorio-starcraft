require("prototypes.entity.helpers")

data:extend({
    {
        type = "explosion",
        name = "starcraft-z_bldg_death_sml",
        animations = create_anim{
            filename = "main_060_diffuse.png",
            frame_count = 12,
            line_length = 8,
            size = { 478, 415 },
            hr_line_length = 4,
            hr_size = { 955, 828 },

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            type = "sound",
            filename = "__starcraft__/sound/zerg/bldg/zbldgdth.wav",
            aggregation = {
                max_count = 4,
                remove = false
            }
        }
    },
    {
        type = "explosion",
        name = "starcraft-t_bldg_death_xlrg",
        animations = create_anim{
            -- TODO: Figure out how ofire remapping works in remastered then remake this
            filename = "main_215_diffuse.png",
            frame_count = 14,
            line_length = 7,
            size = { 534, 557 },
            hr_line_length = 3,
            hr_size = { 1067, 1113 },
            draw_as_glow = true,

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            type = "sound",
            filename = "__starcraft__/sound/misc/explolrg.wav",
            audible_distance_modifier = 40.0,
            aggregation = {
                max_count = 4,
                remove = false
            }
        }
    },
    {
        type = "explosion",
        name = "starcraft-p_bldg_death_xlrg",
        animations = create_anim{
            filename = "main_215_diffuse.png",
            frame_count = 14,
            line_length = 7,
            size = { 534, 557 },
            hr_line_length = 3,
            hr_size = { 1067, 1113 },
            draw_as_glow = true,

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            type = "sound",
            filename = "__starcraft__/sound/misc/explolrg.wav",
            audible_distance_modifier = 40.0,
            aggregation = {
                max_count = 4,
                remove = false
            }
        }
    },
    
})
