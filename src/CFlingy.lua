require("__starcraft__/external/class/class")
require("CThingy")
require("CUnitTypes")

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
    self.data.mf_ordered = false
    self.data.mf_accelerating = false
    self.data.mf_braking = false
    self.data.mf_paused = false
    self.data.mf_lifted = false
    self.data.mf_direction = false
    self.data.mf_ready_to_brake = false

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

function positions_equal(a, b)
    return a[1] == b[1] and a[2] == b[2]
end

function CFlingy:setMoveTarget(target_pos, target_unit)
    if positions_equal(self.data.move_target_pos, target_pos) and (target_unit == nil or target_unit == self.data.move_target_unit) then
        return
    end
    self.data.move_target_pos = target_pos
    self.data.move_target_unit = target_unit
    self.data.next_movement_waypoint = target_pos
    self.data.mf_braking = false
    self.data.mf_ordered = true
end

function CFlingy:setNextTargetWaypoint(position)
    self.data.next_target_waypoint = position
end

-- In sc pixels, need to convert to Factorio (/16)
DIRECTIONS = {
    {0, -256},
    {6, -256},
    {13, -256},
    {19, -255},
    {25, -255},
    {31, -254},
    {38, -253},
    {44, -252},
    {50, -251},
    {56, -250},
    {62, -248},
    {68, -247},
    {74, -245},
    {80, -243},
    {86, -241},
    {92, -239},
    {98, -237},
    {104, -234},
    {109, -231},
    {115, -229},
    {121, -226},
    {126, -223},
    {132, -220},
    {137, -216},
    {142, -213},
    {147, -209},
    {152, -206},
    {157, -202},
    {162, -198},
    {167, -194},
    {172, -190},
    {177, -185},
    {181, -181},
    {185, -177},
    {190, -172},
    {194, -167},
    {198, -162},
    {202, -157},
    {206, -152},
    {209, -147},
    {213, -142},
    {216, -137},
    {220, -132},
    {223, -126},
    {226, -121},
    {229, -115},
    {231, -109},
    {234, -104},
    {237, -98},
    {239, -92},
    {241, -86},
    {243, -80},
    {245, -74},
    {247, -68},
    {248, -62},
    {250, -56},
    {251, -50},
    {252, -44},
    {253, -38},
    {254, -31},
    {255, -25},
    {255, -19},
    {256, -13},
    {256, -6},
    {256, 0},
    {256, 6},
    {256, 13},
    {255, 19},
    {255, 25},
    {254, 31},
    {253, 38},
    {252, 44},
    {251, 50},
    {250, 56},
    {248, 62},
    {247, 68},
    {245, 74},
    {243, 80},
    {241, 86},
    {239, 92},
    {237, 98},
    {234, 104},
    {231, 109},
    {229, 115},
    {226, 121},
    {223, 126},
    {220, 132},
    {216, 137},
    {213, 142},
    {209, 147},
    {206, 152},
    {202, 157},
    {198, 162},
    {194, 167},
    {190, 172},
    {185, 177},
    {181, 181},
    {177, 185},
    {172, 190},
    {167, 194},
    {162, 198},
    {157, 202},
    {152, 206},
    {147, 209},
    {142, 213},
    {137, 216},
    {132, 220},
    {126, 223},
    {121, 226},
    {115, 229},
    {109, 231},
    {104, 234},
    {98, 237},
    {92, 239},
    {86, 241},
    {80, 243},
    {74, 245},
    {68, 247},
    {62, 248},
    {56, 250},
    {50, 251},
    {44, 252},
    {38, 253},
    {31, 254},
    {25, 255},
    {19, 255},
    {13, 256},
    {6, 256},
    {0, 256},
    {-6, 256},
    {-13, 256},
    {-19, 255},
    {-25, 255},
    {-31, 254},
    {-38, 253},
    {-44, 252},
    {-50, 251},
    {-56, 250},
    {-62, 248},
    {-68, 247},
    {-74, 245},
    {-80, 243},
    {-86, 241},
    {-92, 239},
    {-98, 237},
    {-104, 234},
    {-109, 231},
    {-115, 229},
    {-121, 226},
    {-126, 223},
    {-132, 220},
    {-137, 216},
    {-142, 213},
    {-147, 209},
    {-152, 206},
    {-157, 202},
    {-162, 198},
    {-167, 194},
    {-172, 190},
    {-177, 185},
    {-181, 181},
    {-185, 177},
    {-190, 172},
    {-194, 167},
    {-198, 162},
    {-202, 157},
    {-206, 152},
    {-209, 147},
    {-213, 142},
    {-216, 137},
    {-220, 132},
    {-223, 126},
    {-226, 121},
    {-229, 115},
    {-231, 109},
    {-234, 104},
    {-237, 98},
    {-239, 92},
    {-241, 86},
    {-243, 80},
    {-245, 74},
    {-247, 68},
    {-248, 62},
    {-250, 56},
    {-251, 50},
    {-252, 44},
    {-253, 38},
    {-254, 31},
    {-255, 25},
    {-255, 19},
    {-256, 13},
    {-256, 6},
    {-256, 0},
    {-256, -6},
    {-256, -13},
    {-255, -19},
    {-255, -25},
    {-254, -31},
    {-253, -38},
    {-252, -44},
    {-251, -50},
    {-250, -56},
    {-248, -62},
    {-247, -68},
    {-245, -74},
    {-243, -80},
    {-241, -86},
    {-239, -92},
    {-237, -98},
    {-234, -104},
    {-231, -109},
    {-229, -115},
    {-226, -121},
    {-223, -126},
    {-220, -132},
    {-216, -137},
    {-213, -142},
    {-209, -147},
    {-206, -152},
    {-202, -157},
    {-198, -162},
    {-194, -167},
    {-190, -172},
    {-185, -177},
    {-181, -181},
    {-177, -185},
    {-172, -190},
    {-167, -194},
    {-162, -198},
    {-157, -202},
    {-152, -206},
    {-147, -209},
    {-142, -213},
    {-137, -216},
    {-132, -220},
    {-126, -223},
    {-121, -226},
    {-115, -229},
    {-109, -231},
    {-104, -234},
    {-98, -237},
    {-92, -239},
    {-86, -241},
    {-80, -243},
    {-74, -245},
    {-68, -247},
    {-62, -248},
    {-56, -250},
    {-50, -251},
    {-44, -252},
    {-38, -253},
    {-31, -254},
    {-25, -255},
    {-19, -255},
    {-13, -256},
    {-6, -256}
}

for i in DIRECTIONS do
    DIRECTIONS[i] = {DIRECTIONS[i][1] / 16, DIRECTIONS[i][2] / 16}
end

function GetDirectionVector(dir, length)
    return {DIRECTIONS[dir][1] * length, DIRECTIONS[dir][2] * length}
end
