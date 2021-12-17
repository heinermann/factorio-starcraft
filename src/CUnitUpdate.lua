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
    [ORD_GUARD] = function(entity, data)
    end,
    [ORD_GUARD_PLAY] = function(entity, data)
    end,
    [ORD_TURRET_GUARD] = function(entity, data)
    end,
    [ORD_GUARD_BUNKER] = function(entity, data)
    end,
    [ORD_IGNORE] = function(entity, data)
    end,
    [ORD_TRILOBYTE_STOP] = function(entity, data)
    end,
    [ORD_ATTACK] = function(entity, data)
    end,
    [ORD_MOVE_ATTACK_UNIT] = function(entity, data)
    end,
    [ORD_ATTACK_UNIT] = function(entity, data)
    end,
    [ORD_ATTACK_FIXED_RNGE] = function(entity, data)
    end,
    [ORD_ATTACK_TILE] = function(entity, data)
    end,
    [ORD_ATTACK_HOVER] = function(entity, data)
    end,
    [ORD_ATTACK_MOVE] = function(entity, data)
    end,
    [ORD_DRONE_INFEST0] = function(entity, data)
    end,
    [ORD_NOTHING0] = function(entity, data)
    end,
    --[ORD_POWERUP0] = function(entity, data)
    --end,
    [ORD_TOWER_GUARD] = function(entity, data)
    end,
    [ORD_TOWER_ATTACK] = function(entity, data)
    end,
    [ORD_VULTURE_MINE] = function(entity, data)
    end,
    [ORD_STAY_IN_RANGE] = function(entity, data)
    end,
    [ORD_TURRET_ATTACK] = function(entity, data)
    end,
    [ORD_NOTHING] = function(entity, data)
    end,
    [ORD_NOTHING2] = function(entity, data)
    end,
    [ORD_DRONE_START_BUILD] = function(entity, data)
    end,
    [ORD_DRONE_BUILD] = function(entity, data)
    end,
    [ORD_DRONE_INFEST] = function(entity, data)
    end,
    [ORD_DRONE_INFEST2] = function(entity, data)
    end,
    [ORD_QUEEN_INFEST] = function(entity, data)
    end,
    [ORD_BUILD] = function(entity, data)
    end,
    [ORD_BUILDPROTOSS] = function(entity, data)
    end,
    [ORD_PYLON_BUILD] = function(entity, data)
    end,
    [ORD_CONSTRUCT_BLDG] = function(entity, data)
    end,
    [ORD_REPAIR] = function(entity, data)
    end,
    [ORD_REPAIR_MOVE] = function(entity, data)
    end,
    [ORD_PLACE_ADDON] = function(entity, data)
    end,
    [ORD_BUILD_ADDON] = function(entity, data)
    end,
    [ORD_TRAIN] = function(entity, data)
    end,
    [ORD_RALLY_POINT] = function(entity, data)
    end,
    [ORD_RALLY_POINT_TILE] = function(entity, data)
    end,
    [ORD_ZERG_BIRTH] = function(entity, data)
    end,
    [ORD_MORPH] = function(entity, data)
    end,
    [ORD_ZERG_BLDG_MORPH] = function(entity, data)
    end,
    [ORD_BUILDSELF] = function(entity, data)
    end,
    [ORD_BUILDSELFZERG] = function(entity, data)
    end,
    [ORD_BUILDNYDUS] = function(entity, data)
    end,
    [ORD_ENTER_NYDUS] = function(entity, data)
    end,
    --[ORD_BUILDSELFPROTOSS] outsourced to CUnitPBuild.lua
    [ORD_FOLLOW] = function(entity, data)
    end,
    [ORD_CARRIER] = function(entity, data)
    end,
    [ORD_CARRIER_IGNORE] = function(entity, data)
    end,
    [ORD_CARRIER_STOP] = function(entity, data)
    end,
    [ORD_CARRIER_ATTACK] = function(entity, data)
    end,
    [ORD_CARRIER_ATTACK_MOVE] = function(entity, data)
    end,
    [ORD_CARRIER_IGNORE2] = function(entity, data)
    end,
    [ORD_CARRIER_FIGHT] = function(entity, data)
    end,
    [ORD_CARRIER_HOLDPOS] = function(entity, data)
    end,
    [ORD_REAVER] = function(entity, data)
    end,
    [ORD_REAVER_ATTACK] = function(entity, data)
    end,
    [ORD_REAVER_ATTACK_MOVE] = function(entity, data)
    end,
    [ORD_REAVER_FIGHT] = function(entity, data)
    end,
    [ORD_REAVER_HOLD] = function(entity, data)
    end,
    [ORD_TRAIN_FIGHTER] = function(entity, data)
    end,
    [ORD_STRAFE_UNIT] = function(entity, data)
    end,
    [ORD_STRAFE_UNIT_SCARAB] = function(entity, data)
    end,
    [ORD_RECHARGE_UNIT] = function(entity, data)
    end,
    [ORD_RECHARGE] = function(entity, data)
    end,
    [ORD_SHIELD_BATTERY] = function(entity, data)
    end,
    [ORD_RETURN] = function(entity, data)
    end,
    [ORD_DRONE_LAND] = function(entity, data)
    end,
    [ORD_BLDG_LAND] = function(entity, data)
    end,
    [ORD_BLDG_LIFT_OFF] = function(entity, data)
    end,
    [ORD_DRONE_LIFT_OFF] = function(entity, data)
    end,
    [ORD_LIFT_OFF] = function(entity, data)
    end,
    [ORD_RESEARCH_TECH] = function(entity, data)
    end,
    [ORD_UPGRADE] = function(entity, data)
    end,
    [ORD_LARVA] = DispatchLarva,
    [ORD_SPAWN_LARVA] = function(entity, data)
    end,
    [ORD_HARVEST] = function(entity, data)
    end,
    [ORD_HARVEST_MOVE] = function(entity, data)
    end,
    [ORD_HARVEST_GAS] = function(entity, data)
    end,
    [ORD_ENTER_GAS] = function(entity, data)
    end,
    [ORG_IN_GAS] = function(entity, data)
    end,
    [ORD_RETURN_GAS] = function(entity, data)
    end,
    [ORD_HARVEST_MINERALS] = function(entity, data)
    end,
    [ORD_HARVEST_MINERALS_WAIT] = function(entity, data)
    end,
    [ORD_HARVESTING_MINERALS] = function(entity, data)
    end,
    [ORG_HARVEST_INTERRUPT] = function(entity, data)
    end,
    [ORD_HARVEST4] = function(entity, data)
    end,
    [ORD_RETURN_MINERALS] = function(entity, data)
    end,
    [ORG_HARVEST_INTERRUPT2] = function(entity, data)
    end,
    [ORD_ENTER_TRANSPORT] = function(entity, data)
    end,
    [ORD_PICK_UP] = function(entity, data)
    end,
    [ORD_PICK_UP_MOBILE] = function(entity, data)
    end,
    [ORD_PICK_UP_STATIONARY] = function(entity, data)
    end,
    [ORD_PICK_UP_UNK] = function(entity, data)
    end,
    --[ORD_POWERUP] = function(entity, data)
    --end,
    [ORD_SIEGEMODE] = function(entity, data)
    end,
    [ORD_TANKMODE] = function(entity, data)
    end,
    [ORD_WATCHTARGET] = function(entity, data)
    end,
    [ORD_INIT_SPREAD_CREEP] = function(entity, data)
    end,
    [ORD_SPREAD_CREEP] = function(entity, data)
    end,
    [ORD_STOP_SPREAD_CREEP] = function(entity, data)
    end,
    [ORD_GUARDIANASPECT] = function(entity, data)
    end,
    [ORD_SUMMON_ARCHON] = function(entity, data)
    end,
    [ORD_SUMMON_COMPLETE] = function(entity, data)
    end,
    [ORD_HOLDPOS] = function(entity, data)
    end,
    [ORD_HOLDPOS_QUEEN] = function(entity, data)
    end,
    [ORD_CLOAK] = function(entity, data)
    end,
    [ORD_DECLOAK] = function(entity, data)
    end,
    [ORD_UNLOAD] = function(entity, data)
    end,
    [ORD_MOVE_UNLOAD] = function(entity, data)
    end,
    [ORD_YAMATO] = function(entity, data)
    end,
    [ORD_YAMATO_MOVE] = function(entity, data)
    end,
    [ORD_MAGNAPULSE] = function(entity, data)
    end,
    [ORD_BURROW] = function(entity, data)
    end,
    [ORD_BURROWED] = function(entity, data)
    end,
    [ORD_DEBURROW] = function(entity, data)
    end,
    [ORD_DARK_SWARM] = function(entity, data)
    end,
    [ORD_CAST_PARASITE] = function(entity, data)
    end,
    [ORD_SUMMON_BROODLINGS] = function(entity, data)
    end,
    [ORD_EMP_SHOCKWAVE] = function(entity, data)
    end,
    [ORD_NUKE_WAIT] = function(entity, data)
    end,
    [ORD_NUKE_TRAIN] = function(entity, data)
    end,
    [ORD_NUKE_LAUNCH] = function(entity, data)
    end,
    [ORD_NUKE_PAINT] = function(entity, data)
    end,
    [ORD_NUKE_UNIT] = function(entity, data)
    end,
    [ORD_NUKE_GROUND] = function(entity, data)
    end,
    [ORD_NUKE_TRACK] = function(entity, data)
    end,
    [ORD_ARBITER] = function(entity, data)
    end,
    [ORD_CLOAK_NEIGHBORS] = function(entity, data)
    end,
    [ORD_PLACE_MINE] = function(entity, data)
    end,
    [ORD_RCLICK] = function(entity, data)
    end,
    [ORD_SAP_UNIT] = function(entity, data)
    end,
    [ORD_SAP_LOC] = function(entity, data)
    end,
    [ORD_SAP_HOLDPOS] = function(entity, data)
    end,
    [ORD_TELEPORT] = function(entity, data)
    end,
    [ORD_TELEPORT_LOC] = function(entity, data)
    end,
    [ORD_PLACE_SCANNER] = function(entity, data)
    end,
    [ORD_SCANNER] = function(entity, data)
    end,
    [ORD_DEF_MAT] = function(entity, data)
    end,
    [ORD_PSI_STORM] = function(entity, data)
    end,
    [ORD_IRRADIATE] = function(entity, data)
    end,
    [ORD_PLAGUE] = function(entity, data)
    end,
    [ORD_CONSUME] = function(entity, data)
    end,
    [ORD_ENSNARE] = function(entity, data)
    end,
    [ORD_STASIS] = function(entity, data)
    end,
    [ORD_HALLUCINATE] = function(entity, data)
    end,
    [ORD_HALLUCINATION] = function(entity, data)
    end,
    [ORD_UNDO_FLYER] = function(entity, data)
    end,
    [ORD_UNDO_TRANSPARENT_WORKER] = function(entity, data)
    end,
    [ORD_PATROL] = function(entity, data)
    end,
    [ORD_CTF_COP_INIT] = function(entity, data)
    end,
    [ORD_CTF_COP] = function(entity, data)
    end,
    [ORD_CTF_COP_2] = function(entity, data)
    end,
    [ORD_COMP_AI] = DispatchComputerAI,
    [ORD_ATTACK_MOVE_EP] = function(entity, data)
    end,
    [ORD_HARASS_MOVE_EP] = function(entity, data)
    end,
    [ORD_AI_PATROL] = function(entity, data)
    end,
    [ORD_GUARD_POST] = function(entity, data)
    end,
    [ORD_RESCUE_PASSIVE] = function(entity, data)
    end,
    [ORD_NEUTRAL] = function(entity, data)
    end,
    [ORD_COMP_RETURN] = function(entity, data)
    end,
    [ORD_JUICE_INIT] = function(entity, data)
    end,
    [ORD_SELF_DESTRUCT] = function(entity, data)
    end,
    [ORD_CRITTER] = function(entity, data)
    end,
    [ORD_HIDDEN_GUN] = function(entity, data)
    end,
    [ORD_OPEN_DOOR] = function(entity, data)
    end,
    [ORD_CLOSE_DOOR] = function(entity, data)
    end,
    [ORD_HIDE_TRAP] = function(entity, data)
    end,
    [ORD_REVEAL_TRAP] = function(entity, data)
    end,
    --[ORD_ENABLE_DOODAD] = function(entity, data)
    --end,
    --[ORD_DISABLE_DOODAD] = function(entity, data)
    --end,
    [ORD_PROTOSS_WARP_IN] = function(entity, data)
    end,
    [ORD_MEDIC] = function(entity, data)
    end,
    [ORD_MEDIC_HEAL] = function(entity, data)
    end,
    [ORD_MEDIC_HEALMOVE] = function(entity, data)
    end,
    [ORD_MEDIC_HOLDPOS] = function(entity, data)
    end,
    [ORD_MEDIC_RETURN_TO_IDLE] = function(entity, data)
    end,
    [ORD_MEDIC_CURE] = function(entity, data)
    end,
    [ORD_CAST_DISRUPTOR] = function(entity, data)
    end,
    [ORD_MINDCONTROL] = function(entity, data)
    end,
    [ORD_SUMMON_DARCHON] = function(entity, data)
    end,
    [ORD_PSYFEEDBACK] = function(entity, data)
    end,
    [ORD_MYOPIA] = function(entity, data)
    end,
    [ORD_PARALIZE] = function(entity, data)
    end,
    [ORD_JUNK_YARD_DOG] = function(entity, data)
    end,
    --[ORD_FATAL] = function(entity, data)
    --end,
    --[ORD_NONE] = function(entity, data)
    --end,
}

local function RunOrders(entity)
    if not entity.valid then return end


end
