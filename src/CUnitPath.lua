require("CUnit")

UM_Init          = 0
UM_InitSeq       = 1
UM_Lump          = 2
UM_Turret        = 3
UM_Bunker        = 4
UM_BldgTurret    = 5
UM_Hidden        = 6
UM_Flyer         = 7
UM_FakeFlyer     = 8
UM_AtRest        = 9
UM_Dormant       = 10
UM_AtMoveTarget  = 11
UM_CheckIllegal  = 12
UM_MoveToLegal   = 13
UM_LumpWannabe   = 14
UM_FailedPath    = 15
UM_RetryPath     = 16
UM_StartPath     = 17
UM_UIOrderDelay  = 18
UM_TurnAndStart  = 19
UM_FaceTarget    = 20
UM_NewMoveTarget = 21
UM_AnotherPath   = 22
UM_Repath        = 23
UM_RepathMovers  = 24
UM_FollowPath    = 25
UM_ScoutPath     = 26
UM_ScoutFree     = 27
UM_FixCollision  = 28
UM_WaitFree      = 29
UM_GetFree       = 30
UM_SlidePrep     = 31
UM_SlideFree     = 32
UM_ForceMoveFree = 33
UM_FixTerrain    = 34
UM_TerrainSlide  = 35

MF_ORDERED = 1
MF_ACCELERATING = 2
MF_BRAKING = 4
MF_PAUSED = 8
MF_LIFTED = 16
MF_DIRECTION = 32

function CUnit:hidden()
    return self.entity.render_to_forces == nil or #self.entity.render_to_forces == 0
end

function CUnit:in_bunker()
    return self.data.in_bunker
end

function CUnit:iscript_nobrk()
    return self.data.is_no_break_code_section
end

function CUnit:is_turret()
    return false
end

function CUnit:needs_movement()
    return self.data.movement_flags & MF_ACCELERATING ~= 0 or not self:AtMoveTarget()
end

function CUnit:is_burrowed()
    return self.data.is_burrowed
end

function CUnit:can_move()
    return self.data.can_move
end

function CUnit:can_turn()
    return self.data.can_turn
end

function CUnit:set_current_speed(current_speed)
    if self.data.current_speed == current_speed then
        return
    end
    self.data.current_speed = current_speed
    self.velocty = GetDirectionVector(self.data.current_velocity_direction, self.data.current_speed)
end

function CUnit:set_next_speed(next_speed)
    self.data.next_speed = next_speed
    self:set_current_speed(next_speed)
end

function CUnit:stop_moving()
    self.entity.riding_state = {
        acceleration = defines.riding.acceleration.nothing
    }
    self.entity.speed = 0
end

function CUnit:set_move_target(target)
    -- TODO
end

function CUnit:set_immovable()
    self:set_next_speed(0)
    self:stop_moving()
    self:set_move_target(self.entity.position)
    self.data.immovable = true
    self.data.user_flags = self.data.user_flags & ~2
end

function CUnit:update_movement()    -- CFlingy

end

function CUnit:finish_movement()

end

function CUnit:PathInit(ems)
    self.data.terrain_no_collision_bounds = {{0, 0}, {0, 0}}

    self.data.pathing_flags = self.data.pathing_flags & ~(1 | 2)
    if self.data.elevation_level < 12 then
        self.data.pathing_flags = self.data.pathing_flags | 1
    end

    local next_state = UM_Lump
    if self:is_turret() and self:iscript_nobrk() then    -- and is not a subunit
        next_state = UM_InitSeq
    elseif self:in_bunker() then
        next_state = UM_Bunker
    elseif not self:hidden() then
        if self:needs_movement() then
            self:set_immovable()
            self:update_movement()
            self:finish_movement()
        end
        next_state = UM_Hidden
    elseif self:is_burrowed() then
        next_state = UM_Lump
    elseif self:can_move() then
        if self.data.pathing_flags & 1 ~= 0 then
            next_state = UM_AtRest
        else
            next_state = UM_Flyer
        end
    elseif self.data.can_turn then
        if self:is_turret() then
            next_state = UM_Turret
        else
            next_state = UM_BldgTurret
        end
    elseif self.data.pathing_flags & 1 ~= 0 and self:needs_movement() then
        next_state = UM_LumpWannabe
    end

    self.data.movement_state = next_state
    return true
end

function CUnit:PathInitSeq(ems)
    if (self:iscript_nobrk()) then
        return false
    end

    self.data.movement_state = UM_Init
    return true
end

function CUnit:PathTurret(ems)
    self:set_move_target(self.entity.position)
    -- TODO
end

function CUnit:PathBunker(ems)
    -- TODO
    return false
end

function CUnit:PathBldgTurret(ems)
    -- TODO
    return false
end

function CUnit:PathHidden(ems)
    return false
end

function CUnit:PathFlyer(ems)
    -- TODO
end

function CUnit:PathAtRest(ems)
    
end

function CUnit:PathDormant(ems)
end

function CUnit:PathAtMoveTarget(ems)
end

function CUnit:PathCheckIllegal(ems)
end

function CUnit:PathMoveToLegal(ems)
end

function CUnit:PathLumpWannabe(ems)
end

function CUnit:PathFailedPath(ems)
end

function CUnit:PathRetryPath(ems)
end

function CUnit:PathStartPath(ems)
end

function CUnit:PathUIOrderDelay(ems)
end

function CUnit:PathTurnAndStart(ems)
end

function CUnit:PathFaceTarget(ems)
end

function CUnit:PathNewMoveTarget(ems)
end

function CUnit:PathAnotherPath(ems)
end

function CUnit:PathRepath(ems)
end

function CUnit:PathRepathMovers(ems)
end

function CUnit:PathFollowPath(ems)
end

function CUnit:PathScoutPath(ems)
end

function CUnit:PathScoutFree(ems)
    self.data.movement_state = UM_FollowPath
    return true
end

function CUnit:PathFixCollision(ems)
end

function CUnit:PathWaitFree(ems)
end

function CUnit:PathGetFree(ems)
end

function CUnit:PathSlidePrep(ems)
end

function CUnit:PathSlideFree(ems)
end

function CUnit:PathForceMoveFree(ems)
end

function CUnit:PathFixTerrain(ems)
end

function CUnit:PathTerrainSlide(ems)
end

function CUnit:PathFalse(ems)
    return false
end

local path_switch = {
    [UM_Init] = CUnit.PathInit,
    [UM_InitSeq] = CUnit.PathInitSeq,
    [UM_Lump] = CUnit.PathFalse,
    [UM_Turret] = CUnit.PathTurret,
    [UM_Bunker] = CUnit.PathBunker,
    [UM_BldgTurret] = CUnit.PathBldgTurret,
    [UM_Hidden] = CUnit.PathHidden,
    [UM_Flyer] = CUnit.PathFlyer,
    [UM_FakeFlyer] = CUnit.PathFalse,
    [UM_AtRest] = CUnit.PathAtRest,
    [UM_Dormant] = CUnit.PathDormant,
    [UM_AtMoveTarget] = CUnit.PathAtMoveTarget,
    [UM_CheckIllegal] = CUnit.PathCheckIllegal,
    [UM_MoveToLegal] = CUnit.PathMoveToLegal,
    [UM_LumpWannabe] = CUnit.PathLumpWannabe,
    [UM_FailedPath] = CUnit.PathFailedPath,
    [UM_RetryPath] = CUnit.PathRetryPath,
    [UM_StartPath] = CUnit.PathStartPath,
    [UM_UIOrderDelay] = CUnit.PathUIOrderDelay,
    [UM_TurnAndStart] = CUnit.PathTurnAndStart,
    [UM_FaceTarget] = CUnit.PathFaceTarget,
    [UM_NewMoveTarget] = CUnit.PathNewMoveTarget,
    [UM_AnotherPath] = CUnit.PathAnotherPath,
    [UM_Repath] = CUnit.PathRepath,
    [UM_RepathMovers] = CUnit.PathRepathMovers,
    [UM_FollowPath] = CUnit.PathFollowPath,
    [UM_ScoutPath] = CUnit.PathScoutPath,
    [UM_ScoutFree] = CUnit.PathScoutFree,
    [UM_FixCollision] = CUnit.PathFixCollision,
    [UM_WaitFree] = CUnit.PathWaitFree,
    [UM_GetFree] = CUnit.PathGetFree,
    [UM_SlidePrep] = CUnit.PathSlidePrep,
    [UM_SlideFree] = CUnit.PathSlideFree,
    [UM_ForceMoveFree] = CUnit.PathForceMoveFree,
    [UM_FixTerrain] = CUnit.PathFixTerrain,
    [UM_TerrainSlide] = CUnit.PathTerrainSlide,
}

function CUnit:PathCalcMove()
    local ems = {
        starting_movement = false,
        stopping_movement = false,
        speed = 0,
        position = {0, 0},
        exact_position = {0, 0},
        pre_movement_flags = 0,
        post_movement_flags = 0
    }

    local want_loop = false
    repeat
        want_loop = path_switch[self.data.movement_state](ems)
    until not want_loop
end
