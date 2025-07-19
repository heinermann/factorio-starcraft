--[[
    A basic interface script, with generic functions
    usage:
    local interface = require(__starcraft__/external/stdlib/scripts/interface)
    interface.myfunc = function() end
    remote.add_interface(script.mod_name, interface)
    interface.myfunc2 = function() end -- Can even add new functions afterwards!
]] --
local interface = {}
local Table = require('__starcraft__/external/stdlib/utils/table')

local Game = require('__starcraft__/external/stdlib/game')

local ignore_defines = Table.invert { 'anticolor', 'lightcolor', 'color', 'time' }

local function write(data, name, keyignore, maxlevel)
    return serpent.block(data, { comment = false, nocode = true, name = name, keyignore = keyignore, maxlevel = maxlevel })
end

interface['write_global'] = function()
    helpers.remove_path(script.mod_name)

    helpers.write_file(script.mod_name .. '/storage.lua', write(storage, 'storage'))
    helpers.write_file(script.mod_name .. '/package.lua', write(package.loaded, 'package', nil, 1))
    helpers.write_file(script.mod_name .. '/interface.lua', write(remote.interfaces[script.mod_name] or {}, 'interface'))
    helpers.write_file(script.mod_name .. '/_G.lua', write(_G, 'globals', nil, 1))
end

interface['dump_all'] = function()
    helpers.remove_path('Interfaces')

    helpers.write_file('defines.lua', write(defines, 'defines', ignore_defines))

    helpers.write_file('interfaces.lua', write(remote.interfaces, 'interfaces'))
    for name, interfaces in pairs(remote.interfaces) do
        -- Write each interface
        helpers.write_file('Interfaces/' .. name .. '.lua', write(interfaces, 'interface'))
        if interfaces['write_global'] then remote.call(name, 'write_global') end
    end

    Game.write_mods()
    Game.write_surfaces()
    Game.write_statistics()
    game.print('Finished writing all data to script-output')
end

interface['merge_interfaces'] = function(tab)
    Table.merge(interface, tab, false)
    return interface
end

return interface
