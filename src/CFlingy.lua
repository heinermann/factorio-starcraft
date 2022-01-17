require("__starcraft__/external/class/class")
require("CThingy")
require("CUnitTypes")
require("Direction")

CFlingy = class()

function CFlingy:init(entity)
    CThingy.init(self, entity)
end

-- MF_ORDERED = 1
-- MF_ACCELERATING = 2
-- MF_BRAKING = 4
-- MF_PAUSED = 8
-- MF_LIFTED = 16
-- MF_DIRECTION = 32
-- MF_READY_TO_BRAKE = 64

function CFlingy:createInit()
    CThingy.createInit(self)

    -- Replacing movement_flags
    self.data.movement_flags = {
        ordered = false
        accelerating = false
        braking = false
        paused = false
        lifted = false
        direction = false
        ready_to_brake = false
    }

    self.data.next_speed = 0

    local flingy = FLINGY_DATA[self.entity.name]
    self.data.flingy_top_speed = flingy.top_speed or 1
    self.data.flingy_acceleration = flingy.acceleration or 1
    self.data.flingy_turn_rate = flingy.turn_radius or 1
    self.data.flingy_movement_type = flingy.flingy_type

    -- Position and type handled by Factorio

    self.data.move_target_pos = nil
    self.data.move_target_unit = nil

    self:setMoveTarget(self.entity.position)
    self:setNextTargetWaypoint(self.entity.position)

    -- Note: May be Factorio-handled?
    self.data.heading = 0
    self.data.next_velocity_direction = heading
end

-- TODO: move out
function positions_equal(a, b)
    return (a.x or a[1]) == (b.x or b[1]) and (a.y or a[2]) == (b.y or b[2])
end
function positions_add(a, b)
    return {(a.x or a[1]) + (b.x or b[1]), (a.y or a[2]) + (b.y or b[2])}
end

function CFlingy:setMoveTarget(target_pos, target_unit)
    if positions_equal(self.data.move_target_pos, target_pos) and (target_unit == nil or target_unit == self.data.move_target_unit) then
        return
    end
    self.data.move_target_pos = target_pos
    self.data.move_target_unit = target_unit
    self.data.next_movement_waypoint = target_pos
    self.data.movement_flags.braking = false
    self.data.movement_flags.ordered = true
end

function CFlingy:setNextTargetWaypoint(position)
    self.data.next_target_waypoint = position
end

function CFlingy:atMoveTarget()
    return positions_equal(self.entity.position, self.data.move_target_pos)
end

function CFlingy:setCurrentSpeed(speed)
    if self.data.current_speed ~= speed then
        self.data.current_speed = speed
        self.data.velocity = GetDirectionVector(self.data.current_velocity_direction, self.data.current_speed)
    end
end

function CFlingy:setNextSpeed(next_speed)
    self.data.next_speed = next_speed
    self:setCurrentSpeed(next_speed)
end

function CFlingy:stopFlingy()
    if self.data.movement_flags.braking then return end
    self.data.movement_flags.lifted = false
    self.data.movement_flags.direction = false
    self.data.movement_flags.ready_to_brake = false
    self.data.move_target_pos = self.entity.position
    self.data.move_target_unit = nil
    self.data.next_movement_waypoint = self.entity.position
    if self.data.movement_flags.accelerating and self.data.flingy_movement_type == FLINGY_FULL then
        local d = self:haltingDistance()
        self.data.move_target_pos = positions_add(self.entity.position, GetDirectionVector(self.data.next_velocity_direction, d))
        self.data.next_movement_waypoint = self.data.move_target_pos
        if not self:atMoveTarget() then
            self.movement_flags.braking = true
        end
    end
end

function CFlingy:haltingDistance()
    local speed = self.data.next_speed
    if speed == 0 or self.data.flingy_movement_type ~= FLINGY_FULL then
        return 0
    end

    local flingy = FLINGY_DATA[self.entity.name]
    if speed == flingy.top_speed and self.data.flingy_acceleration == flingy.acceleration then
        return flingy.halt_distance
    else
        return speed * speed / self.data.flingy_acceleration / 2
    end
end

function CFlingy:finishFlingyMovement(ems)
    local moved = not positions_equal(self.entity.position, ems.position)

end
