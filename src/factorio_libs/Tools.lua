local halt_distance = {}
local halt_time = {}
local previous_state = {}
local previous_speed = {}
local max_speed = {}

local function measure_halt(player)
  local idx = player.index

  if player.vehicle == nil then
    previous_state[idx] = nil
    previous_speed[idx] = 0
    max_speed[idx] = 0
    return
  end

  --if player.riding_state.acceleration ~= previous_state[idx] then
  --  game.print("Riding state = " .. tostring(player.riding_state.acceleration))
  --end

  max_speed[idx] = math.max(max_speed[idx], player.vehicle.speed)

  if player.riding_state.acceleration == defines.riding.acceleration.nothing then
    if previous_state[idx] ~= defines.riding.acceleration.nothing then
      halt_time[idx] = 0
      halt_distance[idx] = 0
    end

    if player.vehicle.speed ~= 0 then
      halt_time[idx] = halt_time[idx] + 1
      halt_distance[idx] = halt_distance[idx] + player.vehicle.speed
    end

    if previous_speed[idx] ~= 0 and player.vehicle.speed == 0 then
      game.print("Max Speed = " .. tostring(max_speed[idx]) .. "; Halt distance = " .. tostring(halt_distance[idx]) .. "; Halt time = " .. tostring(halt_time[idx]))
    end
  end

  previous_state[idx] = player.riding_state.acceleration
  previous_speed[idx] = player.vehicle.speed
end
