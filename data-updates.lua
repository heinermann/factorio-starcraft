-- Add resources to all planets
for _, planet in pairs(data.raw.planet) do
	local mapgen = planet.map_gen_settings
	local autoplace = mapgen.autoplace_settings
	if autoplace ~= nil then
		mapgen.autoplace_controls["starcraft-resources"] = {}
		autoplace.entity.settings["starcraft-mineral-field"] = {}
		autoplace.entity.settings["starcraft-vespene-geyser"] = {}
	end
end
