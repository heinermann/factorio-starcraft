local forces = {}

-- TODO: Use new force.custom_color write

local function create_new_force(forcename)
    local newforce = game.create_force(forcename)

    newforce.disable_research()
    newforce.disable_all_prototypes()
    newforce.ai_controllable = false
end

function forces.on_init()
    create_new_force("terran")
    create_new_force("protoss")
    create_new_force("zerg")
end

return forces
