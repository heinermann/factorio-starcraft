require("Orders")

local function UNIMPLEMENTED(entity, data)
    game.print("Unimplemented order " .. tostring(data.order or -1))
end

-- CUnitOrder.cpp
local function SetOrderEx(entity, data, order, target_pos, target_unit, target_type, interruptable)
    -- TODO

    data.order = ORD_COMP_AI
end

-- CUnitOrder.cpp
local function ProgressQueuedOrder(entity, data)
    -- TODO
end

-- CUnitOrder.cpp
local function SetOrder(entity, data, order)
    data.user_action_flags = data.user_action_flags | 1
    SetOrderEx(entity, data, order, nil, nil, nil, true)
    ProgressQueuedOrder(entity, data)
end

-- CUnitOrder.cpp
local function EndDispatchOrder(entity, data)
    -- if there's a queued order link
    -- or user flag to 1
    -- call ProgressQueuedOrder

    -- else
    SetOrder(entity, data, ORD_COMP_AI)  -- Otherwise return to idle if it's a human player
end

-- CUnitZerg.cpp
local function DispatchLarva(entity, data)
end

-- CUnitCombat.cpp
local function IsDeadOrDying(entity, data)
    return (not entity.valid) or data.order == ORD_DIE
end

-- SAI_Main.cpp
local function DispatchComputerAI(entity, data)
    if data.order_timer ~= 0 then return end

    data.order_timer = 15 -- * 2.52 TODO: Use EntityUpdateManager to avoid iteration outside of update frames

    if entity.name == "starcraft-larva" then
        DispatchLarva(entity, data)
        if IsDeadOrDying(entity, data) then
            return
        end
    elseif entity.name == "starcraft-medic" then
        -- Something about moving medics where they are needed by the AI
        SetOrder(entity, data, ORD_MEDIC)
        return
    end

    -- Something something AI management

    -- Otherwise switch to computer idle order
end

-- CUnitUpdate.cpp
local function UpdateMoveTargetEntity(entity, data, target)
end

-- CUnitUpdate.cpp
local function UpdateMoveTargetPosition(entity, data, target)
end


-- CUnitMisc.cpp
local function DispatchIgnoreMove(entity, data)
    if data.order_state == 0 then
        local reached_destination = false
        if data.action_focus.unit ~= nil then
            reached_destination = UpdateMoveTargetEntity(entity, data, data.action_focus.unit)
        else
            reached_destination = UpdateMoveTargetPosition(entity, data, data.action_focus.position)
        end

        if reached_destination then
            data.order_state = 1
        end
    elseif data.order_state == 1 then
        EndDispatchOrder(entity, data)
    end
end


local order_dispatch_functions = {
    [ORD_DIE] = function(entity, data)
        -- TODO: Additional logic for decloaking on death
        entity.active = true
        entity.destructible = true
        entity.die()
    end,
    [ORD_STOP] = function(entity, data)
        entity.riding_state = {
            acceleration = defines.riding.acceleration.nothing
        }
        EndDispatchOrder(entity, data)
    end,
    [ORD_GUARD] = UNIMPLEMENTED,
    [ORD_GUARD_PLAY] = UNIMPLEMENTED,
    [ORD_TURRET_GUARD] = UNIMPLEMENTED,
    [ORD_GUARD_BUNKER] = UNIMPLEMENTED,
    [ORD_IGNORE] = UNIMPLEMENTED,
    [ORD_TRILOBYTE_STOP] = UNIMPLEMENTED,
    [ORD_ATTACK] = UNIMPLEMENTED,
    [ORD_MOVE_ATTACK_UNIT] = UNIMPLEMENTED,
    [ORD_ATTACK_UNIT] = UNIMPLEMENTED,
    [ORD_ATTACK_FIXED_RNGE] = UNIMPLEMENTED,
    [ORD_ATTACK_TILE] = UNIMPLEMENTED,
    [ORD_ATTACK_HOVER] = UNIMPLEMENTED,
    [ORD_ATTACK_MOVE] = UNIMPLEMENTED,
    [ORD_DRONE_INFEST0] = UNIMPLEMENTED,
    [ORD_NOTHING0] = UNIMPLEMENTED,
    [ORD_POWERUP0] = UNIMPLEMENTED,
    [ORD_TOWER_GUARD] = UNIMPLEMENTED,
    [ORD_TOWER_ATTACK] = UNIMPLEMENTED,
    [ORD_VULTURE_MINE] = UNIMPLEMENTED,
    [ORD_STAY_IN_RANGE] = UNIMPLEMENTED,
    [ORD_TURRET_ATTACK] = UNIMPLEMENTED,
    [ORD_NOTHING] = UNIMPLEMENTED,
    [ORD_NOTHING2] = UNIMPLEMENTED,
    [ORD_DRONE_START_BUILD] = UNIMPLEMENTED,
    [ORD_DRONE_BUILD] = UNIMPLEMENTED,
    [ORD_DRONE_INFEST] = UNIMPLEMENTED,
    [ORD_DRONE_INFEST2] = UNIMPLEMENTED,
    [ORD_QUEEN_INFEST] = UNIMPLEMENTED,
    [ORD_BUILD] = UNIMPLEMENTED,
    [ORD_BUILDPROTOSS] = UNIMPLEMENTED,
    [ORD_PYLON_BUILD] = UNIMPLEMENTED,
    [ORD_CONSTRUCT_BLDG] = UNIMPLEMENTED,
    [ORD_REPAIR] = UNIMPLEMENTED,
    [ORD_REPAIR_MOVE] = UNIMPLEMENTED,
    [ORD_PLACE_ADDON] = UNIMPLEMENTED,
    [ORD_BUILD_ADDON] = UNIMPLEMENTED,
    [ORD_TRAIN] = UNIMPLEMENTED,
    [ORD_RALLY_POINT] = UNIMPLEMENTED,
    [ORD_RALLY_POINT_TILE] = UNIMPLEMENTED,
    [ORD_ZERG_BIRTH] = UNIMPLEMENTED,
    [ORD_MORPH] = UNIMPLEMENTED,
    [ORD_ZERG_BLDG_MORPH] = UNIMPLEMENTED,
    [ORD_BUILDSELF] = UNIMPLEMENTED,
    [ORD_BUILDSELFZERG] = UNIMPLEMENTED,
    [ORD_BUILDNYDUS] = UNIMPLEMENTED,
    [ORD_ENTER_NYDUS] = UNIMPLEMENTED,
    [ORD_BUILDSELFPROTOSS] = UNIMPLEMENTED, -- outsourced to CUnitPBuild.lua
    [ORD_FOLLOW] = UNIMPLEMENTED,
    [ORD_CARRIER] = UNIMPLEMENTED,
    [ORD_CARRIER_IGNORE] = UNIMPLEMENTED,
    [ORD_CARRIER_STOP] = UNIMPLEMENTED,
    [ORD_CARRIER_ATTACK] = UNIMPLEMENTED,
    [ORD_CARRIER_ATTACK_MOVE] = UNIMPLEMENTED,
    [ORD_CARRIER_IGNORE2] = UNIMPLEMENTED,
    [ORD_CARRIER_FIGHT] = UNIMPLEMENTED,
    [ORD_CARRIER_HOLDPOS] = UNIMPLEMENTED,
    [ORD_REAVER] = UNIMPLEMENTED,
    [ORD_REAVER_ATTACK] = UNIMPLEMENTED,
    [ORD_REAVER_ATTACK_MOVE] = UNIMPLEMENTED,
    [ORD_REAVER_FIGHT] = UNIMPLEMENTED,
    [ORD_REAVER_HOLD] = UNIMPLEMENTED,
    [ORD_TRAIN_FIGHTER] = UNIMPLEMENTED,
    [ORD_STRAFE_UNIT] = UNIMPLEMENTED,
    [ORD_STRAFE_UNIT_SCARAB] = UNIMPLEMENTED,
    [ORD_RECHARGE_UNIT] = UNIMPLEMENTED,
    [ORD_RECHARGE] = UNIMPLEMENTED,
    [ORD_SHIELD_BATTERY] = UNIMPLEMENTED,
    [ORD_RETURN] = UNIMPLEMENTED,
    [ORD_DRONE_LAND] = UNIMPLEMENTED,
    [ORD_BLDG_LAND] = UNIMPLEMENTED,
    [ORD_BLDG_LIFT_OFF] = UNIMPLEMENTED,
    [ORD_DRONE_LIFT_OFF] = UNIMPLEMENTED,
    [ORD_LIFT_OFF] = UNIMPLEMENTED,
    [ORD_RESEARCH_TECH] = UNIMPLEMENTED,
    [ORD_UPGRADE] = UNIMPLEMENTED,
    [ORD_LARVA] = DispatchLarva,
    [ORD_SPAWN_LARVA] = UNIMPLEMENTED,
    [ORD_HARVEST] = UNIMPLEMENTED,
    [ORD_HARVEST_MOVE] = UNIMPLEMENTED,
    [ORD_HARVEST_GAS] = UNIMPLEMENTED,
    [ORD_ENTER_GAS] = UNIMPLEMENTED,
    [ORG_IN_GAS] = UNIMPLEMENTED,
    [ORD_RETURN_GAS] = UNIMPLEMENTED,
    [ORD_HARVEST_MINERALS] = UNIMPLEMENTED,
    [ORD_HARVEST_MINERALS_WAIT] = UNIMPLEMENTED,
    [ORD_HARVESTING_MINERALS] = UNIMPLEMENTED,
    [ORG_HARVEST_INTERRUPT] = UNIMPLEMENTED,
    [ORD_HARVEST4] = UNIMPLEMENTED,
    [ORD_RETURN_MINERALS] = UNIMPLEMENTED,
    [ORG_HARVEST_INTERRUPT2] = UNIMPLEMENTED,
    [ORD_ENTER_TRANSPORT] = UNIMPLEMENTED,
    [ORD_PICK_UP] = UNIMPLEMENTED,
    [ORD_PICK_UP_MOBILE] = UNIMPLEMENTED,
    [ORD_PICK_UP_STATIONARY] = UNIMPLEMENTED,
    [ORD_PICK_UP_UNK] = UNIMPLEMENTED,
    [ORD_POWERUP] = UNIMPLEMENTED,
    [ORD_SIEGEMODE] = UNIMPLEMENTED,
    [ORD_TANKMODE] = UNIMPLEMENTED,
    [ORD_WATCHTARGET] = UNIMPLEMENTED,
    [ORD_INIT_SPREAD_CREEP] = UNIMPLEMENTED,
    [ORD_SPREAD_CREEP] = UNIMPLEMENTED,
    [ORD_STOP_SPREAD_CREEP] = UNIMPLEMENTED,
    [ORD_GUARDIANASPECT] = UNIMPLEMENTED,
    [ORD_SUMMON_ARCHON] = UNIMPLEMENTED,
    [ORD_SUMMON_COMPLETE] = UNIMPLEMENTED,
    [ORD_HOLDPOS] = UNIMPLEMENTED,
    [ORD_HOLDPOS_QUEEN] = UNIMPLEMENTED,
    [ORD_CLOAK] = UNIMPLEMENTED,
    [ORD_DECLOAK] = UNIMPLEMENTED,
    [ORD_UNLOAD] = UNIMPLEMENTED,
    [ORD_MOVE_UNLOAD] = UNIMPLEMENTED,
    [ORD_YAMATO] = UNIMPLEMENTED,
    [ORD_YAMATO_MOVE] = UNIMPLEMENTED,
    [ORD_MAGNAPULSE] = UNIMPLEMENTED,
    [ORD_BURROW] = UNIMPLEMENTED,
    [ORD_BURROWED] = UNIMPLEMENTED,
    [ORD_DEBURROW] = UNIMPLEMENTED,
    [ORD_DARK_SWARM] = UNIMPLEMENTED,
    [ORD_CAST_PARASITE] = UNIMPLEMENTED,
    [ORD_SUMMON_BROODLINGS] = UNIMPLEMENTED,
    [ORD_EMP_SHOCKWAVE] = UNIMPLEMENTED,
    [ORD_NUKE_WAIT] = UNIMPLEMENTED,
    [ORD_NUKE_TRAIN] = UNIMPLEMENTED,
    [ORD_NUKE_LAUNCH] = UNIMPLEMENTED,
    [ORD_NUKE_PAINT] = UNIMPLEMENTED,
    [ORD_NUKE_UNIT] = UNIMPLEMENTED,
    [ORD_NUKE_GROUND] = UNIMPLEMENTED,
    [ORD_NUKE_TRACK] = UNIMPLEMENTED,
    [ORD_ARBITER] = UNIMPLEMENTED,
    [ORD_CLOAK_NEIGHBORS] = UNIMPLEMENTED,
    [ORD_PLACE_MINE] = UNIMPLEMENTED,
    [ORD_RCLICK] = UNIMPLEMENTED,
    [ORD_SAP_UNIT] = UNIMPLEMENTED,
    [ORD_SAP_LOC] = UNIMPLEMENTED,
    [ORD_SAP_HOLDPOS] = UNIMPLEMENTED,
    [ORD_TELEPORT] = UNIMPLEMENTED,
    [ORD_TELEPORT_LOC] = UNIMPLEMENTED,
    [ORD_PLACE_SCANNER] = UNIMPLEMENTED,
    [ORD_SCANNER] = UNIMPLEMENTED,
    [ORD_DEF_MAT] = UNIMPLEMENTED,
    [ORD_PSI_STORM] = UNIMPLEMENTED,
    [ORD_IRRADIATE] = UNIMPLEMENTED,
    [ORD_PLAGUE] = UNIMPLEMENTED,
    [ORD_CONSUME] = UNIMPLEMENTED,
    [ORD_ENSNARE] = UNIMPLEMENTED,
    [ORD_STASIS] = UNIMPLEMENTED,
    [ORD_HALLUCINATE] = UNIMPLEMENTED,
    [ORD_HALLUCINATION] = UNIMPLEMENTED,
    [ORD_UNDO_FLYER] = UNIMPLEMENTED,
    [ORD_UNDO_TRANSPARENT_WORKER] = UNIMPLEMENTED,
    [ORD_PATROL] = UNIMPLEMENTED,
    [ORD_CTF_COP_INIT] = UNIMPLEMENTED,
    [ORD_CTF_COP] = UNIMPLEMENTED,
    [ORD_CTF_COP_2] = UNIMPLEMENTED,
    [ORD_COMP_AI] = DispatchComputerAI,
    [ORD_ATTACK_MOVE_EP] = UNIMPLEMENTED,
    [ORD_HARASS_MOVE_EP] = UNIMPLEMENTED,
    [ORD_AI_PATROL] = UNIMPLEMENTED,
    [ORD_GUARD_POST] = UNIMPLEMENTED,
    [ORD_RESCUE_PASSIVE] = UNIMPLEMENTED,
    [ORD_NEUTRAL] = UNIMPLEMENTED,
    [ORD_COMP_RETURN] = UNIMPLEMENTED,
    [ORD_JUICE_INIT] = UNIMPLEMENTED,
    [ORD_SELF_DESTRUCT] = UNIMPLEMENTED,
    [ORD_CRITTER] = UNIMPLEMENTED,
    [ORD_HIDDEN_GUN] = UNIMPLEMENTED,
    [ORD_OPEN_DOOR] = UNIMPLEMENTED,
    [ORD_CLOSE_DOOR] = UNIMPLEMENTED,
    [ORD_HIDE_TRAP] = UNIMPLEMENTED,
    [ORD_REVEAL_TRAP] = UNIMPLEMENTED,
    [ORD_ENABLE_DOODAD] = UNIMPLEMENTED,
    [ORD_DISABLE_DOODAD] = UNIMPLEMENTED,
    [ORD_PROTOSS_WARP_IN] = UNIMPLEMENTED,
    [ORD_MEDIC] = UNIMPLEMENTED,
    [ORD_MEDIC_HEAL] = UNIMPLEMENTED,
    [ORD_MEDIC_HEALMOVE] = UNIMPLEMENTED,
    [ORD_MEDIC_HOLDPOS] = UNIMPLEMENTED,
    [ORD_MEDIC_RETURN_TO_IDLE] = UNIMPLEMENTED,
    [ORD_MEDIC_CURE] = UNIMPLEMENTED,
    [ORD_CAST_DISRUPTOR] = UNIMPLEMENTED,
    [ORD_MINDCONTROL] = UNIMPLEMENTED,
    [ORD_SUMMON_DARCHON] = UNIMPLEMENTED,
    [ORD_PSYFEEDBACK] = UNIMPLEMENTED,
    [ORD_MYOPIA] = UNIMPLEMENTED,
    [ORD_PARALIZE] = UNIMPLEMENTED,
    [ORD_JUNK_YARD_DOG] = UNIMPLEMENTED,
    [ORD_FATAL] = UNIMPLEMENTED
}

local function RunOrders(entity)
    if not entity.valid then return end


end
