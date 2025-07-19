require("entity.helpers")
local table = require("__starcraft__/external/stdlib/utils/table")

local function create_animation(data)
    local result = create_anim(data)

    result.type = "animation"
    result.name = data.name
    return result
end

local function create_overlay_animation(anim_data)
    anim_data.animation_speed = 1/5
    local cdata = table.deep_copy(anim_data)
    cdata.frame_sequence = {}
    for i = 1, anim_data.frame_count / 2 do
        table.insert(cdata.frame_sequence, i)
    end
    cdata.name = cdata.name .. "-sm"
    local sm_overlay = create_animation(cdata)

    anim_data.frame_sequence = {}
    for i = anim_data.frame_count / 2 + 1, anim_data.frame_count do
        table.insert(anim_data.frame_sequence, i)
    end
    anim_data.name = anim_data.name .. "-lg"
    local lg_overlay = create_animation(anim_data)

    data:extend({
        sm_overlay,
        lg_overlay
    })
end

create_overlay_animation{
    filename = "main_450_diffuse.png",
    name = "starcraft-ofire1",
    frame_count = 24,
    line_length = 24,
    size = { 153, 480 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_451_diffuse.png",
    name = "starcraft-ofire2",
    frame_count = 24,
    line_length = 24,
    size = { 147, 517 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_452_diffuse.png",
    name = "starcraft-ofire3",
    frame_count = 24,
    line_length = 24,
    size = { 140, 555 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_466_diffuse.png",
    name = "starcraft-bfire1",
    frame_count = 24,
    line_length = 24,
    size = { 153, 480 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_467_diffuse.png",
    name = "starcraft-bfire2",
    frame_count = 24,
    line_length = 24,
    size = { 147, 517 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_468_diffuse.png",
    name = "starcraft-bfire3",
    frame_count = 24,
    line_length = 24,
    size = { 140, 555 },
    draw_as_glow = true
}
create_overlay_animation{
    filename = "main_458_diffuse.png",
    name = "starcraft-blood1",
    frame_count = 12,
    line_length = 11,
    size = { 356, 201 },
}
create_overlay_animation{
    filename = "main_459_diffuse.png",
    name = "starcraft-blood2",
    frame_count = 12,
    line_length = 12,
    size = { 131, 232 },
}
create_overlay_animation{
    filename = "main_460_diffuse.png",
    name = "starcraft-blood3",
    frame_count = 12,
    line_length = 12,
    size = { 138, 238 },
}
create_overlay_animation{
    filename = "main_461_diffuse.png",
    name = "starcraft-blood4",
    frame_count = 12,
    line_length = 10,
    size = { 393, 347 },
}
create_overlay_animation{
    filename = "main_458_flipped_diffuse.png",
    name = "starcraft-blood1f",
    frame_count = 12,
    line_length = 11,
    size = { 356, 201 },
}
create_overlay_animation{
    filename = "main_459_flipped_diffuse.png",
    name = "starcraft-blood2f",
    frame_count = 12,
    line_length = 12,
    size = { 131, 232 },
}
create_overlay_animation{
    filename = "main_460_flipped_diffuse.png",
    name = "starcraft-blood3f",
    frame_count = 12,
    line_length = 12,
    size = { 138, 238 },
}
create_overlay_animation{
    filename = "main_461_flipped_diffuse.png",
    name = "starcraft-blood4f",
    frame_count = 12,
    line_length = 10,
    size = { 393, 347 },
}
