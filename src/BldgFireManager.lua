local Entity = require('__starcraft__/external/stdlib/entity/entity')
local table = require("__starcraft__/external/stdlib/utils/table")

local BldgFireManager = {}

local function sc_pixels_to_factorio_tiles(value)
    return value / 32 * 2
end

local function to_factorio_offsets(offsets)
    for index, offset in ipairs(offsets) do
        offsets[index] = { sc_pixels_to_factorio_tiles(offset[1]), sc_pixels_to_factorio_tiles(offset[2]) }
    end
    return offsets
end

local overlay_data = {
    ["starcraft-cerebrate"] = {
        animations = { "starcraft-blood2", "starcraft-blood3", "starcraft-blood4", "starcraft-blood2f" },
        offsets = to_factorio_offsets{ {19, -14}, {-19, -13}, {-15, -23}, {-10, 7} }
    },
    ["starcraft-daggoth"] = {
        animations = { "starcraft-blood2", "starcraft-blood3", "starcraft-blood4", "starcraft-blood2f" },
        offsets = to_factorio_offsets{ {19, -14}, {-19, -13}, {-15, -23}, {-10, 7} }
    },
    ["starcraft-infested-command-center"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-44, -30}, {26, -18}, {-7, -24} }
    },
    ["starcraft-spawning-pool"] = {
        animations = { "starcraft-blood1f", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-15, -24}, {22, -3} }
    },
    ["starcraft-evo-chamber"] = {
        animations = { "starcraft-blood2f", "starcraft-blood3f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-31, -4}, {-14, -14}, {40, -30} }
    },
    ["starcraft-creep-colony"] = {
        animations = { "starcraft-blood3f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-13, -9}, {25, -22} }
    },
    ["starcraft-hatchery"] = {
        animations = { "starcraft-blood3", "starcraft-blood4" },
        offsets = to_factorio_offsets{ {25, -9}, {-13, -19} }
    },
    ["starcraft-hive"] = {
        animations = { "starcraft-blood2", "starcraft-blood3", "starcraft-blood4" },
        offsets = to_factorio_offsets{ {1, -31}, {28, 2}, {-64, -31} }
    },
    ["starcraft-lair"] = {
        animations = { "starcraft-blood4", "starcraft-blood2f", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-58, -32}, {5, -7}, {22, -31} }
    },
    ["starcraft-sunken-colony"] = {
        animations = { "starcraft-blood2", "starcraft-blood3f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-22, -21}, {-18, 9}, {-4, -23} }
    },
    ["starcraft-greater-spire"] = {
        animations = { "starcraft-blood2f", "starcraft-blood3f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-6, -58}, {-21, 1}, {31, -43} }
    },
    ["starcraft-defiler-mound"] = {
        animations = { "starcraft-blood4", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-20, -14}, {36, -9} }
    },
    ["starcraft-queens-nest"] = {
        animations = { "starcraft-blood3", "starcraft-blood2f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {21, 8}, {-20, -5}, {26, -28} }
    },
    ["starcraft-nydus"] = {
        animations = { "starcraft-blood2f", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-6, -25}, {33, -12} }
    },
    ["starcraft-ultra-cavern"] = {
        animations = { "starcraft-blood4", "starcraft-blood2f", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-23, -10}, {-15, -52}, {1, -16} }
    },
    ["starcraft-extractor"] = {
        animations = { "starcraft-blood2", "starcraft-blood4", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-6, -48}, {20, -50}, {2, 1} }
    },
    ["starcraft-hydra-den"] = {
        animations = { "starcraft-blood3", "starcraft-blood4f" },
        offsets = to_factorio_offsets{ {-16, -25}, {18, -16} }
    },
    ["starcraft-spire"] = {
        animations = { "starcraft-blood2", "starcraft-blood3" },
        offsets = to_factorio_offsets{ {13, -55}, {-8, -54} }
    },
    ["starcraft-spore-colony"] = {
        animations = { "starcraft-blood2f", "starcraft-blood3f" },
        offsets = to_factorio_offsets{ {-7, -16}, {2, 11} }
    },
    ["starcraft-archives"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-4, -34}, {13, -3}, {33, 7} }
    },
    ["starcraft-assimilator"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-10, -46}, {18, -47}, {38, -20} }
    },
    ["starcraft-observatory"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {33, -15}, {-10, 2}, {-9, -20} }
    },
    ["starcraft-citadel"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-1, -35}, {29, -30} }
    },
    ["starcraft-forge"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {23, -48}, {18, -5}, {-19, 9} }
    },
    ["starcraft-gateway"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-4, -56}, {34, 10}, {-39, -23} }
    },
    ["starcraft-cyber-core"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {0, -42}, {22, 4} }
    },
    ["starcraft-khaydarin-crystal-formation"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-24, -12}, {15, -20}, {3, 5} }
    },
    ["starcraft-nexus"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-4, -36}, {40, 22}, {-3, 38} }
    },
    ["starcraft-cannon"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-7, -20}, {10, -2} }
    },
    ["starcraft-tribunal"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-25, 3}, {19, -3}, {1, -14} }
    },
    ["starcraft-pylon"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {12, 3}, {-2, -9} }
    },
    ["starcraft-robotics-facility"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-21, -19}, {15, -14}, {8, 8} }
    },
    ["starcraft-shield-battery"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-6, -23}, {3, -8} }
    },
    ["starcraft-stargate"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {6, -71}, {-7, -54}, {34, 3} }
    },
    ["starcraft-robotics-support-bay"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {-24, -12}, {15, -20}, {3, 5} }
    },
    ["starcraft-fleet-beacon"] = {
        animations = { "starcraft-bfire1", "starcraft-bfire2", "starcraft-bfire3" },
        offsets = to_factorio_offsets{ {1, -54}, {-24, -13}, {38, -36} }
    },
    ["starcraft-academy"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-22, -37}, {5, -2}, {30, -51} }
    },
    ["starcraft-barracks"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-27, -48}, {-4, -9}, {25, 3} }
    },
    ["starcraft-armory"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-17, -10}, {28, -26}, {-5, -28} }
    },
    ["starcraft-comsat"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-5, -20}, {9, 2} }
    },
    ["starcraft-command-center"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-44, -30}, {26, -18}, {-7, -24} }
    },
    ["starcraft-depot"] = {
        animations = { "starcraft-ofire1" },
        offsets = to_factorio_offsets{ {-23, -26} }
    },
    ["starcraft-control-tower"] = {
        animations = { "starcraft-ofire1" },
        offsets = to_factorio_offsets{ {-13, -26} }
    },
    ["starcraft-factory"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-38, -45}, {3, -45}, {41, -24} }
    },
    ["starcraft-covert-ops"] = {
        animations = { "starcraft-ofire1" },
        offsets = to_factorio_offsets{ {-10, -17} }
    },
    ["starcraft-machine-shop"] = {
        animations = { "starcraft-ofire1" },
        offsets = to_factorio_offsets{ {-12, -28} }
    },
    ["starcraft-turret"] = {
        animations = { "starcraft-ofire2" },
        offsets = to_factorio_offsets{ {-3, -6} }
    },
    ["starcraft-crashed-norad"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-12, -20}, {13, 1} }
    },
    ["starcraft-physics-lab"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-12, -20}, {13, 1} }
    },
    ["starcraft-bunker"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2" },
        offsets = to_factorio_offsets{ {8, -23}, {-21, -21} }
    },
    ["starcraft-refinery"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-21, -23}, {39, -9}, {-4, 3} }
    },
    ["starcraft-science-facility"] = {
        animations = { "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-20, -6}, {24, -30} }
    },
    ["starcraft-nuke-silo"] = {
        animations = { "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-7, -25}, {15, -13} }
    },
    ["starcraft-starport"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-24, -11}, {25, -46}, {6, 1} }
    },
    ["starcraft-engineering-bay"] = {
        animations = { "starcraft-ofire1", "starcraft-ofire2", "starcraft-ofire3" },
        offsets = to_factorio_offsets{ {-34, -25}, {4, -43}, {11, 3} }
    },
}

local sm_to_lg_transitions = {
    ["starcraft-ofire1-sm"] = "starcraft-ofire1-lg",
    ["starcraft-ofire2-sm"] = "starcraft-ofire2-lg",
    ["starcraft-ofire3-sm"] = "starcraft-ofire3-lg",
    ["starcraft-bfire1-sm"] = "starcraft-bfire1-lg",
    ["starcraft-bfire2-sm"] = "starcraft-bfire2-lg",
    ["starcraft-bfire3-sm"] = "starcraft-bfire3-lg",
    ["starcraft-blood1-sm"] = "starcraft-blood1-lg",
    ["starcraft-blood2-sm"] = "starcraft-blood2-lg",
    ["starcraft-blood3-sm"] = "starcraft-blood3-lg",
    ["starcraft-blood4-sm"] = "starcraft-blood4-lg",
    ["starcraft-blood1f-sm"] = "starcraft-blood1f-lg",
    ["starcraft-blood2f-sm"] = "starcraft-blood2f-lg",
    ["starcraft-blood3f-sm"] = "starcraft-blood3f-lg",
    ["starcraft-blood4f-sm"] = "starcraft-blood4f-lg",
}

local lg_to_sm_transitions = {
    ["starcraft-ofire1-lg"] = "starcraft-ofire1-sm",
    ["starcraft-ofire2-lg"] = "starcraft-ofire2-sm",
    ["starcraft-ofire3-lg"] = "starcraft-ofire3-sm",
    ["starcraft-bfire1-lg"] = "starcraft-bfire1-sm",
    ["starcraft-bfire2-lg"] = "starcraft-bfire2-sm",
    ["starcraft-bfire3-lg"] = "starcraft-bfire3-sm",
    ["starcraft-blood1-lg"] = "starcraft-blood1-sm",
    ["starcraft-blood2-lg"] = "starcraft-blood2-sm",
    ["starcraft-blood3-lg"] = "starcraft-blood3-sm",
    ["starcraft-blood4-lg"] = "starcraft-blood4-sm",
    ["starcraft-blood1f-lg"] = "starcraft-blood1f-sm",
    ["starcraft-blood2f-lg"] = "starcraft-blood2f-sm",
    ["starcraft-blood3f-lg"] = "starcraft-blood3f-sm",
    ["starcraft-blood4f-lg"] = "starcraft-blood4f-sm",
}



local function DecreaseDmgOverlays(entity, data)
    -- Iterate all overlays, find the first large overlay and replace it with a small overlay
    for _, anim in pairs(data.overlays or {}) do
        local transition_name = lg_to_sm_transitions[anim.animation]
        if transition_name ~= nil then
            anim.animation = transition_name
            return
        end
    end

    -- If a large overlay wasn't found, remove the first small overlay
    for slot, anim in pairs(data.overlays or {}) do
        anim.destroy()
        data.overlays[slot] = nil
        return
    end
end

local function IncreaseDmgOverlays(entity, data)
    local overlays = overlay_data[entity.name]
    local slots_available = {}
    for i = 1, #overlays.animations do
        slots_available[i] = true
    end

    -- Iterate overlays, find the first small overlay and replace it with a large overlay
    for slot, anim in pairs(data.overlays or {}) do
        local transition_name = sm_to_lg_transitions[anim.animation]
        if transition_name ~= nil then
            anim.animation = transition_name
            return
        end
        slots_available[slot] = nil
    end

    -- If no small overlays are found, choose a random overlay position to create a small overlay
    local slots = table.keys(slots_available)
    local target_slot = slots[math.random(#slots)]

    if data.overlays == nil then
        data.overlays = {}
    end

    data.overlays[target_slot] = rendering.draw_animation{
        animation = overlays.animations[target_slot] .. "-sm",
        render_layer = "higher-object-above",   -- TODO: Flying buildings
        target = entity,
        target_offset = overlays.offsets[target_slot],
        surface = entity.surface
    }
end

local function UpdateDmgOverlays(entity)
    local overlays = overlay_data[entity.name]
    if overlays == nil then return end
    local data = Entity.get_data(entity) or {}

    local num_dmg_overlays = #overlays.animations   -- Number of overlay positions * 2 (small + big overlays)
    local current_overlay_state = data.overlay_state or 0 -- starts as numDmgOverlays (would be a data member)

    local onethird_health = math.floor(entity.max_health / 3)
    local total_state_health = entity.max_health - onethird_health
    local num_dmg_states = math.floor(total_state_health / (num_dmg_overlays*2 + 1))
    local desired_state = math.floor((entity.health - total_state_health % num_dmg_states - onethird_health - 1) / num_dmg_states)
    if desired_state < 0 then desired_state = 0 end

    -- Inverted from Starcraft logic, to avoid having to pre-initialize an overlay state on entity creation
    desired_state = num_dmg_overlays - desired_state

    while current_overlay_state > desired_state do
        DecreaseDmgOverlays(entity, data)
        current_overlay_state = current_overlay_state - 1
    end
    while current_overlay_state < desired_state do
        IncreaseDmgOverlays(entity, data)
        current_overlay_state = current_overlay_state + 1
    end

    data.overlay_state = current_overlay_state
    Entity.set_data(entity, data)
end

function BldgFireManager.update_overlays(entity)
    UpdateDmgOverlays(entity)
end

return BldgFireManager
