require("CUnit")
require("PathState")

-- 1 = pf_collision_check
-- 2 = pf_illegal
-- 4 = pf_recheck_legal

function CUnit:needsMovement()
    return self.data.movement_flags.accelerating or not self:atMoveTarget()
end

function CUnit:stopMoving()
    if self.data.pf_illegal then
        self.data.pf_recheck_legal = true
    end
    self:stopFlingy()

    --self.entity.riding_state = {
    --    acceleration = defines.riding.acceleration.nothing
    --}
    --self.entity.speed = 0
    self.data.move_target_timer = 15
end

function CUnit:setImmovable()
    self:setNextSpeed(0)
    self:stopMoving()
    self:setMoveTarget(self.entity.position)
    self.data.sf_immovable = true
end

function CUnit:updateMovement()    -- CFlingy

end

function CUnit:finishMovement()

end

function CUnit:PathInit(ems)
    self.data.pf_collision_check = false
    self.data.pf_illegal = false
    if self.data.elevation_level < 12 then
        self.data.pf_collision_check = true
    end

    self.data.terrain_no_collision_bounds = {{0, 0}, {0, 0}}

    local next_state = UM_Lump
    if self:isTurret() and self.data.sf_iscript_nobrk then
        next_state = UM_InitSeq
    elseif self.data.sf_in_bunker then
        next_state = UM_Bunker
    elseif self:hidden() then
        if self:needsMovement() then
            self:setImmovable()
            self:updateMovement()
            self:finishMovement()
        end
        next_state = UM_Hidden
    elseif self.data.sf_burrowed then
        next_state = UM_Lump
    elseif self.data.sf_can_move then
        if self.data.pf_collision_check then
            next_state = UM_AtRest
        else
            next_state = UM_Flyer
        end
    elseif self.data.sf_can_turn then
        if self:isTurret() then
            next_state = UM_Turret
        else
            next_state = UM_BldgTurret
        end
    elseif self.data.pf_collision_check and self:needsMovement() then
        next_state = UM_LumpWannabe
    end

    self.data.movement_state = next_state
    return true
end

function CUnit:PathInitSeq(ems)
    if not self.data.sf_iscript_nobrk then
        return false
    end

    self.data.movement_state = UM_Init
    return true
end

function CUnit:PathTurret(ems)
    --self:set_move_target(self.entity.position)
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

local function UNUSED(unit, ems)
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
    [UM_FakeFlyer] = UNUSED,
    [UM_AtRest] = CUnit.PathAtRest,
    [UM_Dormant] = CUnit.PathDormant,
    [UM_AtMoveTarget] = CUnit.PathAtMoveTarget,
    [UM_CheckIllegal] = CUnit.PathCheckIllegal,
    [UM_MoveToLegal] = CUnit.PathMoveToLegal,
    [UM_LumpWannabe] = CUnit.PathLumpWannabe,
    [UM_FailedPath] = CUnit.PathFailedPath,
    [UM_RetryPath] = CUnit.PathRetryPath,
    [UM_StartPath] = CUnit.PathStartPath,
    [UM_UIOrderDelay] = UNUSED,
    [UM_TurnAndStart] = CUnit.PathTurnAndStart,
    [UM_FaceTarget] = CUnit.PathFaceTarget,
    [UM_NewMoveTarget] = CUnit.PathNewMoveTarget,
    [UM_AnotherPath] = CUnit.PathAnotherPath,
    [UM_Repath] = CUnit.PathRepath,
    [UM_RepathMovers] = CUnit.PathRepathMovers,
    [UM_FollowPath] = CUnit.PathFollowPath,
    [UM_ScoutPath] = CUnit.PathScoutPath,
    [UM_ScoutFree] = UNUSED,
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
        pre_movement_flags = {
            ordered = false
            accelerating = false
            braking = false
            paused = false
            lifted = false
            direction = false
            ready_to_brake = false
        },
        post_movement_flags = {
            ordered = false
            accelerating = false
            braking = false
            paused = false
            lifted = false
            direction = false
            ready_to_brake = false
        }
    }

    local want_loop = false
    repeat
        want_loop = path_switch[self.data.movement_state](self, ems)
    until not want_loop
end
