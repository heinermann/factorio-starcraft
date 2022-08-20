local forces = {}

local function create_new_force(forcename, color)
    local newforce = game.create_force(forcename)

    newforce.disable_research()
    newforce.disable_all_prototypes()
    newforce.ai_controllable = false
    newforce.custom_color = color
end

function forces.on_init()
    create_new_force("terran", {12, 72, 204})
    create_new_force("protoss", {252, 252, 56})
    create_new_force("zerg", {136, 64, 156})
end

return forces
