--- The game module.
-- @module Game
-- @usage local Game = require('__starcraft__/external/stdlib/game')

local Game = {
    __class = 'Game',
    __index = require('__starcraft__/external/stdlib/core')
}
setmetatable(Game, Game)
local inspect = _ENV.inspect

--- Messages all players currently connected to the game.
--> Offline players are not counted as having received the message.
-- If no players exist msg is stored in the `global._print_queue` table.
-- @tparam string msg the message to send to players
-- @tparam[opt] ?|nil|boolean condition the condition to be true for a player to be messaged
-- @treturn uint the number of players who received the message.
function Game.print_all(msg, condition)
    local num = 0
    if #game.players > 0 then
        for _, player in pairs(game.players) do
            if condition == nil or select(2, pcall(condition, player)) then
                player.print(msg)
                num = num + 1
            end
        end
        return num
    else
        storage._print_queue = storage._print_queue or {}
        storage._print_queue[#storage._print_queue + 1] = msg
    end
end

--- Gets or sets data in the global variable.
-- @tparam string sub_table the name of the table to use to store data.
-- @tparam[opt] mixed index an optional index to use for the sub_table
-- @tparam mixed key the key to store the data in
-- @tparam[opt] boolean set store the contents of value, when true return previously stored data
-- @tparam[opt] mixed value when set is true set key to this value, if not set and key is empty store this
-- @treturn mixed the chunk value stored at the key or the previous value
function Game.get_or_set_data(sub_table, index, key, set, value)
    assert(type(sub_table) == 'string', 'sub_table must be a string')
    storage[sub_table] = storage[sub_table] or {}
    local this
    if index then
        storage[sub_table][index] = storage[sub_table][index] or {}
        this = storage[sub_table][index]
    else
        this = storage[sub_table]
    end
    local previous

    if set then
        previous = this[key]
        this[key] = value
        return previous
    elseif not this[key] and value then
        this[key] = value
        return this[key]
    end
    return this[key]
end

function Game.write_mods()
    helpers.write_file('Mods.lua', 'return ' .. inspect(game.active_mods))
end

function Game.write_statistics()
    local pre = 'Statistics/' .. game.tick .. '/'
    for _, force in pairs(game.forces) do
        local folder = pre .. force.name .. '/'
        for _, count_type in pairs { 'input_counts', 'output_counts' } do
            helpers.write_file(folder .. 'pollution-' .. count_type .. '.json', helpers.table_to_json(game.pollution_statistics[count_type]))
            helpers.write_file(folder .. 'item-' .. count_type .. '.json', helpers.table_to_json(force.item_production_statistics[count_type]))
            helpers.write_file(folder .. 'fluid-' .. count_type .. '.json', helpers.table_to_json(force.fluid_production_statistics[count_type]))
            helpers.write_file(folder .. 'kill-' .. count_type .. '.json', helpers.table_to_json(force.kill_count_statistics[count_type]))
            helpers.write_file(folder .. 'build-' .. count_type .. '.json', helpers.table_to_json(force.entity_build_count_statistics[count_type]))
        end
    end
end

function Game.write_surfaces()
    helpers.remove_path('surfaces')
    for _, surface in pairs(game.surfaces) do
        helpers.write_file('surfaces/' .. (surface.name or surface.index) .. '.lua', 'return ' .. inspect(surface.map_gen_settings))
    end
end

return Game
