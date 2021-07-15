
local function make_rubble_anim(data)
    return {
        filename = "__starcraft__/graphics/low/" .. data.name .. "_diffuse.png",
        size = data.size,
        frame_count = 4,
        line_length = 4,
        animation_speed = 1/1890, -- Each frame lasts 31.5 seconds in Starcraft

        hr_version = {
            filename = "__starcraft__/graphics/hd/" .. data.name .. "_diffuse.png",
            size = data.hr_size,
            scale = 0.5,
            frame_count = 4,
            line_length = 4,
            animation_speed = data.animation_speed,
        }
    }
end

local function make_glowy_rubble_anim(data)
    local main_anim = make_rubble_anim(data)
    local emissive = make_rubble_anim(data)

    emissive.filename = "__starcraft__/graphics/low/" .. data.name .. "_emissive.png"
    emissive.blend_mode = "additive"
    emissive.draw_as_light = true

    emissive.hr_version.filename = "__starcraft__/graphics/hd/" .. data.name .. "_emissive.png"
    emissive.hr_version.blend_mode = "additive"
    emissive.hr_version.draw_as_light = true

    return {
        layers = {
            main_anim,
            emissive
        }
    }
end

local function make_corpse(data)
    return {
        type = "corpse",
        name = data.name,
        subgroup = "starcraft-mechanics",
        flags = {"placeable-neutral", "not-on-map"},
        selectable_in_game = false,

        remove_on_entity_placement = false,
        remove_on_tile_placement = false,
        time_before_shading_off = 0,
        time_before_removed = 60 * 126, -- 126 seconds (31.5 * 4 anim frames)

        ground_patch = data.ground_patch
    }
end


data:extend({
    make_corpse{
        name = "starcraft-t_bldg_rubble_lrg",
        ground_patch = make_rubble_anim{
            name = "main_336",
            size = { 237, 233 },
            hr_size = { 473, 467 }
        }
    },
    make_corpse{
        name = "starcraft-t_bldg_rubble_sml",
        ground_patch = make_rubble_anim{
            name = "main_335",
            size = { 178, 170 },
            hr_size = { 356, 340 }
        }
    },
    make_corpse{
        name = "starcraft-p_bldg_rubble_lrg",
        ground_patch = make_glowy_rubble_anim{
            name = "main_217",
            size = { 224, 247 },
            hr_size = { 446, 493 }
        }
    },
    make_corpse{
        name = "starcraft-p_bldg_rubble_sml",
        ground_patch = make_glowy_rubble_anim{
            name = "main_217",
            size = { 157, 173 },
            hr_size = { 313, 348 }
        }
    },
    make_corpse{
        name = "starcraft-z_bldg_rubble_lrg",
        ground_patch = make_rubble_anim{
            name = "main_111",
            size = { 254, 230 },
            hr_size = { 509, 459 }
        }
    },
    make_corpse{
        name = "starcraft-z_bldg_rubble_sml",
        ground_patch = make_rubble_anim{
            name = "main_110",
            size = { 173, 164 },
            hr_size = { 346, 329 }
        }
    },

})
