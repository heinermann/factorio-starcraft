require("prototypes.entity.helpers")

data:extend({
    {
        type = "explosion",
        name = "starcraft-z_bldg_death_sml",
        animations = create_anim{
            filename = "main_060_diffuse.png",
            frame_count = 12,
            line_length = 4,
            size = { 955, 828 },

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            filename = "__starcraft__/sound/zerg/bldg/zbldgdth.wav",
            aggregation = {
                max_count = 4,
                remove = false,
                count_already_playing = true
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
            line_length = 3,
            size = { 1067, 1113 },
            draw_as_glow = true,

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            filename = "__starcraft__/sound/misc/explolrg.wav",
            aggregation = {
                max_count = 4,
                remove = false,
                count_already_playing = true
            }
        }
    },
    {
        type = "explosion",
        name = "starcraft-p_explode_death_xlrg",
        animations = create_anim{
            filename = "main_215_diffuse.png",
            frame_count = 14,
            line_length = 3,
            size = { 1067, 1113 },
            draw_as_glow = true,

            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            filename = "__starcraft__/sound/misc/explolrg.wav",
            aggregation = {
                max_count = 4,
                remove = false,
                count_already_playing = true
            }
        }
    },
    {
        type = "explosion",
        name = "starcraft-scout-death",
        animations = create_anim{
            filename = "main_213_diffuse.png",
            frame_count = 9,
            line_length = 8,
            size = { 489, 529 },
            draw_as_glow = true,
            animation_speed = 1/5 -- 84 ms per frame
        },
        sound = {
            filename = "__starcraft__/sound/protoss/scout/pscdth00.wav",
            aggregation = {
                max_count = 4,
                remove = false,
                count_already_playing = true
            }
        }
    },
    {
        type = "explosion",
        name = "starcraft-warp-anchor-death",
        animations = create_anim{
            filename = "main_211_diffuse.png",
            frame_count = 14,
            line_length = 6,
            size = { 596, 599 },
            draw_as_glow = true,
            frame_sequence = {
                8, 8, 8, 8, 8,
                7, 7, 7, 7, 7,
                6, 6, 6, 6, 6,
                5, 5, 5, 5, 5,
                4, 4, 4, 4, 4,
                3, 3, 3, 3, 3
            },
            vshift = 1
            --animation_speed = 1/5 -- 84 ms per frame
        }
    },
})
