require("__starcraft__/external/class/class")
require("CThingy")
require("CUnitTypes")
require("Direction")
local math = require('__stdlib__/stdlib/utils/math')
local table = require('__stdlib__/stdlib/utils/table')
local Position = require("factorio_libs.Position")

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

function CFlingy:setMoveTarget(target_pos, target_unit)
    if Position.equal(self.data.move_target_pos, target_pos) and (target_unit == nil or target_unit == self.data.move_target_unit) then
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
    return Position.equal(self.entity.position, self.data.move_target_pos)
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
        self.data.move_target_pos = Position.add(self.entity.position, GetDirectionVector(self.data.next_velocity_direction, d))
        self.data.next_movement_waypoint = self.data.move_target_pos
        if not self:atMoveTarget() then
            self.movement_flags.braking = true
        end
    end
end

function CFlingy:brakingHalt()
    self.data.movement_flags.braking = false
    self:setCurrentSpeed(0)
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

function CFlingy:finishMovement(ems)
    local moved = not Position.equal(self.entity.position, ems.position)
    self.data.movement_flags = ems.post_movement_flags
    self.data.next_speed = self.data.current_speed
    -- TODO: investigate issues with this, switch to regular Factorio movement instead
    self.entity.teleport(ems.position)
    self:updateHeading(self.data.current_velocity_direction)
    if ems.stopping_movement then
        -- TODO: play walking to idle anim
    elseif ems.starting_movement then
        -- TODO: play walking anim
    end
    return moved
end

function CFlingy:updateHeading(velocity_direction)
    self.data.next_velocity_direction = velocity_direction
    if not self.data.movement_flags.accelerating or self.data.movement_flags.ordered then
        -- TODO: Investigate skipping this and directly doing Factorio shenanigans
        local turn = self.data.desired_velocity_direction - self.data.heading
        turn = math.clamp(turn, -self.data.flingy_turn_rate, self.data.flingy_turn_rate)
        self.data.heading += turn
        if velocity_direction == self.data.desired_velocity_direction and self.data.heading == self.data.desired_velocity_direction then
            self.data.movement_flags.ordered = false
        end
    end
    self.entity.orientation = self.data.heading
end

function CFlingy:updateMovementValues(ems)
    ems.pre_movement_flags = table.deep_copy(self.data.movement_flags)
    self:updateCurrentVelocityDirectionTowardsWaypoint()
    self:updateCurrentSpeedTowardsWaypoint()
    self:setEmsFlags(ems)
    self:setEmsValues(ems)
    ems.post_movement_flags = table.deep_copy(self.data.movement_flags)
    self.data.movement_flags = table.deep_copy(ems.pre_movement_flags)
end

function CFlingy:updateCurrentVelocityDirectionTowardsWaypoint()
    if self.entity.position ~= self.data.next_movement_waypoint then
        self:setDesiredVelocityDirection(PositionToDirection(Position.subtract(self.data.next_movement_waypoint, self.entity.position)))
    elseif self.entity.position ~= self.data.next_target_waypoint then
        self:setDesiredVelocityDirection(PositionToDirection(Position.subtract(self.data.next_target_waypoint, self.entity.position)))
    else
       self:setDesiredVelocityDirection(self.data.heading)
    end
end

function CFlingy:getTurnRate(desired_turn)
    local turn_rate = self.data.flingy_turn_rate
    if self.data.flingy_movement_type ~= FLINGY_ISCRIPT then
        turn_rate = turn_rate / 2
    end
    return math.clamp(desired_turn, -turn_rate, turn_rate)
end

function CFlingy:setDesiredVelocityDirection(direction)
    self.data.desired_velocity_direction = direction
    if self.data.next_velocity_direction ~= direction then
        local turn = self:getTurnRate(direction - self.data.next_velocity_direction)
        self:setCurrentVelocityDirection(self.data.next_velocity_direction - turn)
    else
        self:setCurrentVelocityDirection(direction)
    end
end

function CFlingy:setCurrentVelocityDirection(direction)
    if self.data.current_velocity_direction == direction then return end
    self.data.current_velocity_direction = direction
    self.data.velocity = GetDirectionVector(direction, self.data.current_speed)
end

function CFLingy:updateCurrentSpeedTowardsWaypoint()
    if self.data.flingy_movement_type == FLINGY_FULL then
        if self:atMoveTarget() and self.data.next_speed < 192 then
            if not self.data.movement_flags.direction and not self.data.movement_flags.ready_to_brake then
                self:brakingHalt()
                return
            end
        end
    elseif self.data.flingy_movement_type == FLINGY_PARTIAL then
        if self:atMoveTarget() then
            self:brakingHalt()
            return
        end
    elseif self.data.flingy_movement_type == FLINGY_ISCRIPT then
        if self:atMoveTarget() then
            self:brakingHalt()
        else
            if not self.data.movement_flags.ordered then
                self:setCurrentSpeed(self.data.next_speed)
            else
                local heading_error = self.data.heading - self.data.desired_velocity_direction
                if heading_error >= 32 then
                    if self.data.movement_flags.accelerating then
                        self.data.movement_flags.accelerating = false
                        self:brakingHalt()
                    end
                else
                    self:setCurrentSpeed(self.data.next_speed)
                end
            end
        end
        return
    end
    self:setCurrentSpeed(self.data.next_speed)
    local d = Position.distance(self.data.next_movement_waypoint, self.entity.position)
    local accelerate = false
    if self.data.current_velocity_direction == self.data.desired_velocity_direction then
        accelerate = true
    elseif d >= 32 then
        accelerate = true
    else
        local turn_rate = self.data.flingy_turn_rate
        local diff = self.data.desired_velocity_direction - self.data.current_velocity_direction
        local val = (diff * 2 + turn_rate - 1) / turn_rate * self.data.next_speed
        if val * 3 / 2 <= d then
            accelerate = true
        end
    end

    if accelerate and self.data.flingy_movement_type == FLINGY_FULL then
        if not self.data.movement_flags.direction or not Position.equals(self.data.next_movement_waypoint, self.data.move_target_pos) then
            if not self.data.movement_flags.lifted or self.data.movement_flags.ready_to_brake then
                local remaining_d = Position.distance(self.data.next_movement_waypoint, self.entity.position)
                if self:haltingDistance() >= remaining_d then
                    accelerate = false
                end
            end
        end
    end

    local speed = self.data.current_speed
    if accelerate then
        speed = speed + self.data.flingy_acceleration
    else
        speed = speed - self.data.flingy_acceleration
    end

    speed = math.clamp(speed, 0, self.data.flingy_top_speed)
    self:setCurrentSpeed(speed)
end

function CFlingy:setEmsFlags(ems)
    ems.starting_movement = false
    ems.stopping_movement = false
    if self:atMoveTarget() then
        if self.data.movement_flags.accelerating then
            self.data.movement_flags.accelerating = false
            if not self.data.movement_flags.paused then
                ems.stopping_movement = true
            end
        end
    else
        if not self.data.movement_flags.accelerating then
            if self.data.flingy_movement_type ~= FLINGY_ISCRIPT or not self.data.movement_flags.paused then
                self.data.movement_flags.accelerating = true
            end
            if not self.data.movement_flags.paused then
                ems.starting_movement = true
            end
        end
    end
end

function CFlingy:setEmsValues(ems)
    ems.speed = self.data.current_speed
    if not self.data.movement_flags.accelerating or self.data.current_speed == 0 then
        ems.position = self.entity.position
    else
        local remaining_d = Position.distance(self.data.next_movement_waypoint, self.entity.position)
        if self.data.current_speed >= remaining_d then
            ems.position = self.data.next_movement_waypoint
            ems.speed = remaining_d
        else
            ems.position = Position.add(self.entity.position, self.data.velocity)
        end

        if self.data.flingy_movement_type == FLINGY_ISCRIPT then
            self:setCurrentSpeed(0)
        end
    end
end

