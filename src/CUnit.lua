require("__starcraft__/external/class/class")
require("CFlingy")
require("Orders")
require("PathState")
require("CUnitTypes")

CUnit = class()

function CUnit:init(entity)
    CFlingy.init(self, entity)
end

function CUnit:createInit()
    self.data.order_queue = {}
    self.data.auto_target_unit = nil
    self.data.connected_unit = nil

    self.data.order_process_timer = 0
    self.data.previous_unit_type = nil

    self.data.remove_timer = 0
    self.data.defensive_matrix_hp = 0
    --self.data.defensive_matrix_timer = 0
    --self.data.irradiate_timer = 0
    self.data.storm_timer = 0   -- TODO: get rid of this
    self.data.irradiated_by = nil

    -- TODO: Replace status handling to be primarily stickers with a StatusHandler
    -- This is to be compatible with and affect regular factorio entities
    self.data.parasite_players = {}     -- as opposed to flags
    self.data.cycle_counter = 0     -- TODO: replace
    self.data.blind = false     -- as opposed to blinded_by
    self.data.acid_spore_count = 0  -- TODO replace
    self.data.acid_spore_time = {0, 0, 0, 0, 0, 0, 0, 0, 0}  -- TODO replace

    -- Replacement for status_flags
    self.data.sf_completed = false
    self.data.sf_grounded_building = false
    self.data.sf_flying = false
    self.data.sf_auto_attack = false  -- flag_8
    self.data.sf_burrowed = false
    self.data.sf_in_bunker = false
    self.data.sf_loaded = false
    self.data.sf_requires_detector = false
    self.data.sf_cloaked = false
      --self.data.sf_disabled = false -- handled by Factorio
    self.data.sf_passively_cloaked = false
    self.data.sf_order_not_interruptible = false
    self.data.sf_iscript_nobrk = false
    self.data.sf_cannot_attack = false
    self.data.sf_can_turn = false
    self.data.sf_can_move = false
    self.data.sf_collision = false
    self.data.sf_immovable = false
    self.data.sf_ground_unit = false
    self.data.sf_no_collide = false
    self.data.sf_gathering = false
    self.data.sf_turret_walking = false
      --self.data.sf_invincible = false   -- handled by Factorio
    self.data.sf_ready_to_attack = false
    self.data.sf_speed_upgrade = false
    self.data.sf_cooldown_upgrade = false
    self.data.sf_hallucination = false

    -- Replacement for pathing_flags
    self.data.pf_collision_check = false
    self.data.pf_illegal = false
    self.data.pf_recheck_legal = false

    self.data.previous_hp = 1

    self:createInitType()

    self.data.build_queue = {}
    -- Unit ID gen tracked by factorio
    -- Wireframe rng N/A

    -- Default HP handled by Factorio

    -- Grounded Building orders handled out of scope from here / directly in managers
    self.data.order_type = ORD_NOTHING
    self:setSecondaryOrder(ORD_NOTHING)

    -- Unit finder handled by Factorio
    -- Unit counts and stats handled by Factorio
    -- Tile occupied flags handled by Factorio

    -- Unit visibility mechanics are different, created units no longer start off invisible at the structure until completed
    -- but are created post-completion, simplifying things

    -- TODO: Detection handling
    -- Can't use flags since Factorio allows unlimited players
    -- nil = all, {} = none
    self.data.detected_forces = nil

    -- There's a sprite flag set for turrets/subunits, might not be used

    if IS_VULTURE_TYPE[self.entity.name] then
        self.data.vulture.spider_mine_count = 3
    end
end

-- PF_COLLISION_CHECK = 1
-- PF_ILLEGAL = 2
-- PF_RECHECK_LEGAL = 4

function CUnit:createInitType()
    CFlingy.createInit(self)

    -- Factorio handles owner
    self.data.order_type = ORD_FATAL
    self.data.order_state = 0
    self.data.order_signal = 0
    self.data.order_unit_type = nil
    self.data.main_order_timer = 0

    self.data.ground_weapon_cooldown = 0
    self.data.air_weapon_cooldown = 0
    self.data.spell_cooldown = 0

    self.data.order_target_unit = nil
    self.data.order_target_pos = nil
    -- Factorio handles unit type

    -- Replacing carrying_flags
    self.data.cf_minerals = false
    self.data.cf_gas = false

    self.data.secondary_order_timer = 0

    -- TODO: iscript_execute_sprite ?

    -- self.data.last_attacking_player = nil    -- N/A
    -- Shields dealt with by ShieldManager

    -- TODO: Move to an EnergyManager class?
    if self.entity.name == "starcraft-shield-battery" then
        self.data.energy = 100
    else
        self.data.energy = 200 / 4  -- unit_max_energy(u) / 4
    end

    self.data.elevation_level = UNIT_ELEVATION_LEVEL[self.entity.name] or 4

    self.data.sf_grounded_building = IS_BUILDING[self.entity.name] or IS_BEACON_TYPE[self.entity.name]
    self.data.sf_flying = IS_FLYER[self.entity.name]
    self.data.sf_can_turn = CAN_TURN[self.entity.name]
    self.data.sf_can_move = CAN_MOVE[self.entity.name]
    self.data.sf_ground_unit = not self.data.sf_flying

    self.data.pf_collision_check = self.data.elevation_level < 12

    self.data.building = {
        addon = nil,
        addon_build_type = nil,
        upgrade_research_time = 0,
        researching_type = nil,
        upgrading_type = nil,
        larva_timer = 0,
        is_landing = false,
        creep_timer = 0,
        upgrading_level = 0,

        resource = {
            resource_count = 0,
            resource_iscript = 0,
            is_being_gathered = false,
            gather_queue = {},
        },
        silo = {
            nuke = nil,
            ready = false
        },
        hatchery = {
            larva_spawn_side_values = {0, 0, 0, 0}
        },
        nydus = {
            exit = nil
        },
        ghost = {
            nuke_dot = nil
        },
        vulture = {
            spider_mine_count = 0
        },
        carrier_reaver = {
            inside_hanger = {},
            outside_hanger = {}
        },
        fighter = {
            parent = nil,
            is_outside = false
        },
        worker = {
            powerup = nil,
            target_resource_position = nil,
            target_resource_unit = nil,
            repair_timer = 0,
            is_gathering = false,
            resources_carried = 0,
            gather_target = nil
        }
    }

    self.data.path = nil
    self.data.movement_state = UM_Init
    self.data.move_target_timer = 0
    --if type is invincible, make invincible

    --self.data.remaining_build_time = 
    --self.data.hp_construction_rate = TODO: Maybe unnecessary, handled by CUnitPBuild

    self:updateUnitSpeedUpgrades()
    self:updateUnitSpeed()
end

function CUnit:updateUnitSpeedUpgrades()
    -- TODO: Speed upgrade logic, ignoring for now
end

function CUnit:updateUnitSpeed()
    local flingy = FLINGY_DATA[self.entity.name]
    if flingy ~= nil then
        if self.data.flingy_movement_type == FLINGY_ISCRIPT then
            self.data.flingy_top_speed = flingy.top_speed
        else
            self.data.flingy_top_speed = self:getModifiedUnitSpeed(flingy.top_speed)
            self.data.flingy_acceleration = self:getModifiedUnitAcceleration(flingy.acceleration)
            self.data.flingy_turn_rate = self:getModifiedUnitTurnRate(flingy.turn_radius)
        end
    else
        self.data.flingy_top_speed = 0
        self.data.flingy_acceleration = 0
        self.data.turn_rate = 0
    end
end

function CUnit:getSpeedMod()
    local mod = 0
    if self.data.has_sticker_stim then
        mod = mod + 1
    end
    if self.data.sf_speed_upgrade then
        mod = mod + 1
    end
    if self.data.has_sticker_ensnare then
        mod = mod - 1
    end

    return mod
end

function CUnit:getModifiedUnitSpeed(speed)
    local mod = self:getSpeedMod()

    if mod < 0 then
        speed = speed - speed / 2
    elseif mod > 0 then
        if IS_SCOUT_TYPE[self.entity.name] then
            speed = 1707 / 256
        else
            speed = speed + speed / 2
            local min_speed = 853 / 256
            if speed < min_speed then
                speed = min_speed
            end
        end
    end
    return speed
end

function CUnit:getModifiedUnitAcceleration(acceleration)
    local mod = self:getSpeedMod()

    if mod < 0 then
        acceleration = acceleration - acceleration / 4
    elseif mod > 0 then
        acceleration = acceleration * 2
    end
    return acceleration
end

function CUnit:getModifiedUnitTurnRate(turn_rate)
    local mod = self:getSpeedMod()

    if mod < 0 then
        turn_rate = turn_rate - turn_rate / 4
    elseif mod > 0 then
        turn_rate = turn_rate * 2
    end
    return turn_rate
end

function CUnit:spiderMineCount()
    if IS_VULTURE_TYPE[self.entity.name] then
        return self.data.vulture.spider_mine_count
    end
    return 0
end

function CUnit:addon()
    return self.data.building.addon
end

function CUnit:canBeInfested()
    return self.entity.name == "starcraft-command-center" and self.entity.get_health_ratio() < 0.5
end

function CUnit:setSecondaryOrder(order_type)
    if self.data.secondary_order_type ~= order_type then
        self.data.secondary_order_type = order_type
        self.data.secondary_order_state = 0
        self.data.current_build_unit = nil
    end
end

function CUnit:makeNeutral()
    if self.data.secondary_order_type == ORD_BUILD_ADDON and self.data.sf_grounded_building and self.data.current_build_unit ~= nil then
        local build_unit = CUnit(self.data.current_build_unit)
        if not build_unit.data.sf_completed then
            build_unit:cancelConstruction()
        end 
    end
    self:giveTo("neutral")
    self:setSecondaryOrder(ORD_NOTHING)
end

function CUnit:cancelConstruction()
    -- TODO, this is just a stub
    self.entity.destroy()
end

function CUnit:giveTo(force)
    -- TODO this is a stub
    -- TODO: tech/upgrade transfer
    -- Cancel training, upgrading, and research
    self.entity.force = force
    -- Apply all acquired tech/upgrades to the players' own units
    -- More stuff
end

function CUnit:abandonAddon()
    if self.data.building.addon ~= nil then
        local addon = CUnit(self.data.building.addon)
        addon:makeNeutral()
        self.data.building.addon = nil
        -- TODO: run addon detach anim (liftoff)
    end
end

-- Consider hidden if it's only rendered to the neutral force
function CUnit:hidden()
    local forces = self.entity.render_to_forces
    return forces ~= nil and #forces == 1 and forces[1].name == "neutral"
end

function CUnit:isTurret()
    return IS_SUBUNIT_TYPE[self.entity.name]
end
