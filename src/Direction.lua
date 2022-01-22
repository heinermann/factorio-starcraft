-- In sc pixels, conversion to Factorio (/16) is below
local DIRECTIONS = {
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

function PositionToDirection(pos)
    local x = pos.x or pos[1]
    local y = pos.y or pos[2]
    if x == 0 then
        if y <= 0 then
            return 0
        else
            return -128
        end
    end
    local r = math.atan(y, x) / (math.pi / 2) * 128
    if x > 0 then
        r = r + 64
    else
        r = r - 64
    end
    return r
end
